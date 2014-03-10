#ifndef NETWORKDISCOVERY_H
#define NETWORKDISCOVERY_H

#include <QObject>
#include <QNetworkSession>
#include <QTcpServer>
#include <QTcpSocket>
#include <QUdpSocket>

#include <QQmlParserStatus>

/**
 * @brief Simple network discovery using UDP.
 */
class NetworkDiscovery : public QObject, public QQmlParserStatus {

    Q_OBJECT

    Q_PROPERTY(QString broadcastAddress READ getBroadcastAddress WRITE setBroadcastAddress)
    Q_PROPERTY(int     broadcastPort    READ getBroadcastPort    WRITE setBroadcastPort   )

    Q_INTERFACES(QQmlParserStatus)

public:
    /**
     * @brief NetworkDiscovery constructor.
     *
     * @param parent
     */
    explicit NetworkDiscovery(QObject *parent = 0);

    /**
     * @brief getBroadcastAddress
     *
     * @return
     */
    const QString& getBroadcastAddress() const {
        return broadcastAddress;
    }

    /**
     * @brief setBroadcastAddress
     *
     * @param broadcastAddress
     */
    void setBroadcastAddress(const QString& broadcastAddress) {
        this->broadcastAddress = broadcastAddress;
    }

    /**
     * @brief getBroadcastPort
     *
     * @return
     */
    int getBroadcastPort() const {
        return broadcastPort;
    }

    /**
     * @brief setBroadcastPort
     *
     * @param broadcastPort
     */
    void setBroadcastPort(int broadcastPort) {
        this->broadcastPort = broadcastPort;
    }

    // This interface not needed right now but keeping them around for the time being...
    virtual void classBegin() {
    }

    virtual void componentComplete() {
    }

    /**
     *
     */
    Q_INVOKABLE void discoverServer();

signals:

    /**
     * @brief Server was discovered.
     *
     * @param host discovered host name
     * @param port discovered port number
     */
    void discoveredServer(QString host, int port);

public slots:

private slots:
    void sessionOpened();
    void newConnection();
    void readMessage();

private:
    void prepareBroadcastSocket();
    void prepareNetworkSession();
    void prepareListenServer();

    QString broadcastAddress;
    int broadcastPort;
    QUdpSocket *broadcastSocket;

    QTcpServer *tcpServer;
    QNetworkSession *networkSession;
    QString listenAddress;
    quint16 listenPort;

    QTcpSocket *clientSocket;

    static const QString& PROTOCOL_FIND_SERVER_REQUEST;
    static const QString& PROTOCOL_FIND_SERVER_REPLY;
};

#endif // NETWORKDISCOVERY_H
