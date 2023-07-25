import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml 2.15

import NetworkUtil 1.0
import "../BannerView.qml" as BannerView

ScrollView{

    Column{
        BannerView{
            id: bannerView
        }
    }
    Component.onCompleted: {
        getBannerList();
    }

    HttpUtils{
        id: http
    }

    function getBannerList(){

        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var bannerReply = JSON.parse(reply).banners
            bannerView.bannerList = bannerReply
        }

        http.onReplySignal.connect(onReply);
        http.connet("banner");
    }
}
