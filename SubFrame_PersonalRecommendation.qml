import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import NetworkUtil 1.0
import QtGraphicalEffects 1.15

Item {
    id: subFramePersonal
    width: parent.width
    height: bannerView.height + recommendedPlayList.height + songGridLayout.height + 60

    signal songList(var id)
    BannerView{
        id: bannerView
        width: parent.width
        height: 230
    }

    Text{
        id: recommendedPlayList
        width: parent.width
        height: contentHeight
        text: "推荐歌单"
        font.family: "楷体"
        font.pixelSize: 20
        font.bold: true
        anchors.left: parent.left
        anchors.top: bannerView.bottom
        anchors.topMargin: 25
    }

    GridLayout{
        id: songGridLayout
        width: parent.width
        columns: 5
        columnSpacing: 20
        rowSpacing: 20
        anchors.top: recommendedPlayList.bottom
        anchors.topMargin: 15
        Repeater{
            id: songListRepeater
            delegate: Rectangle{
                Layout.preferredWidth: (songGridLayout.width - 4 * songGridLayout.columnSpacing) / 5
                Layout.preferredHeight: Layout.preferredWidth + descriptionText.lineCount * 14 + 10
                Layout.alignment: Qt.AlignTop

                Rectangle{
                    id: imageRect
                    width: parent.width
                    height: width
                    radius: 5
                    Image{
                        id: image
                        anchors.fill: parent
                        layer.enabled: true
                        source: modelData.picUrl
                        layer.effect: OpacityMask{
                            anchors.fill: parent
                            maskSource: mask
                        }
                    }
                    Rectangle{
                        id:mask
                        anchors.fill: parent
                        visible: false
                        radius: 5
                    }
                    MouseArea{
                        id: imageRectMouseArea
                        anchors.fill: imageRect
                        hoverEnabled: true
                        onEntered: {
                            cursorShape = Qt.PointingHandCursor
                        }
                        onClicked:
                        {
                            songList(modelData.id)
                        }
                    }
                }
                Text{
                    id: descriptionText
                    width: imageRect.width
                    height: implicitHeight
                    anchors.left: imageRect.left
                    anchors.top: imageRect.bottom
                    anchors.topMargin: 5
                    font.pixelSize: 14
                    font.family: "楷体"
                    color: "#222222"
                    text: modelData.name
                    wrapMode: Text.WordWrap
                    MouseArea{
                        id: descriptionTextMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked:
                        {
                            songList(modelData.id)
                        }
                        onEntered: {
                            cursorShape = Qt.PointingHandCursor
                            parent.color = "black"
                        }
                        onExited: {
                            parent.color = "#222222"
                        }
                    }
                }
            }
        }
    }


    Component.onCompleted: {
        getBannerList();
    }

    function getRecommendedSongList(){

        function onReplyGetRecommendedSongList(reply){
            mainWindow.http.onReplySignal.disconnect(onReplyGetRecommendedSongList)
            var recommendedSongList = JSON.parse(reply).result
            songListRepeater.model = recommendedSongList
        }

        mainWindow.http.onReplySignal.connect(onReplyGetRecommendedSongList);
        mainWindow.http.connet("personalized?limit=20");
    }

    function getBannerList(){

        function onReply(reply){
            mainWindow.http.onReplySignal.disconnect(onReply)
            var bannerReply = JSON.parse(reply).banners
            bannerView.bannerList = bannerReply
            getRecommendedSongList();
        }

        mainWindow.http.onReplySignal.connect(onReply);
        mainWindow.http.connet("banner");
    }
}

