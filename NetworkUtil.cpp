#include "NetworkUtil.h"

NetworkUtil::NetworkUtil(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager(this);

    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));

}

void NetworkUtil::connet(QString url)
{
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + url));
    manager->get(request);
}

void NetworkUtil::replyFinished(QNetworkReply *reply)
{
    emit replySignal(reply->readAll());
}
