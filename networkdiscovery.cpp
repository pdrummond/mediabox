#include "networkdiscovery.h"

#include <QNetworkConfigurationManager>
#include <QSettings>

const QString& NetworkDiscovery::PROTOCOL_FIND_SERVER_REQUEST = "MEDIABOX?";
const QString& NetworkDiscovery::PROTOCOL_FIND_SERVER_REPLY = "^MEDIABOX!(\\d+)$";

// FIXME the implementation of the listen socket here is basically copied from an example
//       need to work out if it can be simplified, e.g. by removing the QNetworkConfigurationManager stuff
// FIXME discoverServer() maybe needs to return an error indicator, or we need to somehow otherwise
//       handle and notify the case where the network resources could not be created

/**
 * @brief NetworkDiscovery constructor.
 *
 * The simple protocol works as follows:
 *
 *  1. Send a UDP broadcast packet to the configured broadcast address and port, the message payload
 *     including the port number that this client is listening on;
 *  2. Server receives the broadcast and verifies the message;
 *  3. Sender opens a direct TCP connection to the client adderss and the supplied client port;
 *  4. Server sends an acknowledgement message through the TCP socket back to the client, the message
 *     payload containing the port number that the server is listening on for web-services;
 *  5. Client receives the TCP message;
 *  6. Client infers the server IP address from the socket, and extracts the port number from the
 *     message payload.
 *  7. Client now has the IP address and port number to use when accessing the server web-services.
 *
 * @param parent
 */
NetworkDiscovery::NetworkDiscovery(QObject *parent) : QObject(parent) {
    prepareBroadcastSocket();
    prepareNetworkSession();
}

void NetworkDiscovery::discoverServer() {
    qDebug() << "[>] discoverServer()";
    QByteArray data;
    data.append(PROTOCOL_FIND_SERVER_REQUEST);
    data.append(QString::number(listenPort));
    broadcastSocket->writeDatagram(data, QHostAddress(broadcastAddress), broadcastPort);
    qDebug() << "[<] discoverServer()";
}

void NetworkDiscovery::prepareBroadcastSocket() {
   qDebug() << "[>] prepareBroadcastSocket()";
   broadcastSocket = new QUdpSocket(this);
   qDebug() << "[<] prepareBroadcastSocket()";
}

void NetworkDiscovery::prepareNetworkSession() {
    qDebug() << "[>] prepareNetworkSession()";
    QNetworkConfigurationManager manager;
    // FIXME: Android does not seem to go down this first path... is it needed?
    if (manager.capabilities() & QNetworkConfigurationManager::NetworkSessionRequired) {
        QSettings settings(QSettings::UserScope, QLatin1String("QtProject"));
        settings.beginGroup(QLatin1String("QtNetwork"));
        const QString id = settings.value(QLatin1String("DefaultNetworkConfiguration")).toString();
        settings.endGroup();
        QNetworkConfiguration config = manager.configurationFromIdentifier(id);
        if ((config.state() & QNetworkConfiguration::Discovered) != QNetworkConfiguration::Discovered) {
            config = manager.defaultConfiguration();
        }
        networkSession = new QNetworkSession(config, this);
        connect(networkSession, &QNetworkSession::opened, this, &NetworkDiscovery::sessionOpened);
        networkSession->open();
    }
    else {
        sessionOpened();
    }
    qDebug() << "[<] prepareNetworkSession()";
}

void NetworkDiscovery::prepareListenServer() {
    qDebug() << "[>] prepareListenServer()";
    tcpServer = new QTcpServer(this);
    if (!tcpServer->listen()) {
        qDebug() << "Failed to start server";
        // FIXME???
//        close();
        return;
    }
    QString ipAddress;
    QList<QHostAddress> ipAddressesList = QNetworkInterface::allAddresses();
    // use the first non-localhost IPv4 address FIXME is this right in all cases?
    for (int i = 0; i < ipAddressesList.size(); ++i) {
        if (ipAddressesList.at(i) != QHostAddress::LocalHost && ipAddressesList.at(i).toIPv4Address()) {
            ipAddress = ipAddressesList.at(i).toString();
            break;
        }
    }
    // if we did not find one, use IPv4 localhost
    if (ipAddress.isEmpty()) {
        ipAddress = QHostAddress(QHostAddress::LocalHost).toString();
    }

    listenAddress = ipAddress;
    listenPort = tcpServer->serverPort();

    connect(tcpServer, &QTcpServer::newConnection, this, &NetworkDiscovery::newConnection);

    qDebug() << "[<] prepareListenServer()";
}

void NetworkDiscovery::sessionOpened() {
    qDebug() << "[>] sessionOpened()";

    // FIXME: Android is not using network session, so can this code be removed?
    if (networkSession) {
        QNetworkConfiguration config = networkSession->configuration();
        QString id;
        if (config.type() == QNetworkConfiguration::UserChoice) {
            id = networkSession->sessionProperty(QLatin1String("UserChoiceConfiguration")).toString();
        }
        else {
            id = config.identifier();
        }
        QSettings settings(QSettings::UserScope, QLatin1String("QtProject"));
        settings.beginGroup(QLatin1String("QtNetwork"));
        settings.setValue(QLatin1String("DefaultNetworkConfiguration"), id);
        settings.endGroup();
    }
    prepareListenServer();

    qDebug() << "[<] sessionOpened()";
}

void NetworkDiscovery::newConnection() {
    qDebug() << "[>] newConnection()";
    clientSocket = tcpServer->nextPendingConnection();
    connect(clientSocket, &QTcpSocket::disconnected, clientSocket, &QTcpSocket::deleteLater);
    connect(clientSocket, &QTcpSocket::readyRead, this, &NetworkDiscovery::readMessage);
    qDebug() << "[<] newConnection()";
}

void NetworkDiscovery::readMessage() {
    qDebug() << "[>] readMessage()";

    QString serverAddress = clientSocket->peerAddress().toString();

    QString messageBuffer;
    while (clientSocket->bytesAvailable()) {
        messageBuffer.append(clientSocket->readAll());
    }
    qDebug() << "RECEIVED: " + messageBuffer;

    clientSocket->disconnectFromHost();
//    delete clientSocket;
//    clientSocket = NULL;

    QRegExp rx(PROTOCOL_FIND_SERVER_REPLY);
    if (rx.exactMatch(messageBuffer)) {
        qDebug() << "Got valid response";
        int serverPort = rx.cap(1).toInt();
        emit discoveredServer(serverAddress, serverPort);
    }
    else {
        qDebug() << "Got unknown response";
    }

    qDebug() << "[<] readMessage()";
}
