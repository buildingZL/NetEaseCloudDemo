#ifndef NETWORKUTIL_H
#define NETWORKUTIL_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class NetworkUtil : public QObject
{
    Q_OBJECT
public:
    explicit NetworkUtil(QObject *parent = nullptr);

    Q_INVOKABLE void connet(QString url);
    Q_INVOKABLE void replyFinished(QNetworkReply* reply);
signals:
    void replySignal(QString reply);

private:
    QNetworkAccessManager *manager;
    QString BASE_URL = "http://localhost:3000/";
};

#endif // NETWORKUTIL_H
