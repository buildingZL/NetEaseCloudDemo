import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {
    id: root
    width: parent.width
    height: parent.height
    property var preSubFrame
    signal subframeSignal(real pre, real curr)
    signal songListInDetailsDiscover(var songId)

    RowLayout{
        id: rowTextBtn
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 25
        Layout.fillWidth: true
        Text{
            id: personalRecommendation
            text:"个性推荐"
            font.family: "楷体"
            font.pixelSize: 16
            Layout.rightMargin: 20
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    subPage.source = "SubFrame_PersonalRecommendation.qml"
                    parent.font.bold = true
                    parent.font.pixelSize = 20
                    subframeSignal(preSubFrame, 0)
                }
            }
        }
        Text{
            id: exclusiveCustomization
            text:"专属定制"
            font.family: "楷体"
            font.pixelSize: 16
            Layout.rightMargin: 20
            MouseArea{
                anchors.fill: parent

                onClicked: {
                    subPage.source = "SubFrame_ExclusiveCustomization.qml"
                    parent.font.bold = true
                    parent.font.pixelSize = 20
                    subframeSignal(preSubFrame, 1)
                }
            }
        }
        Text{
            id: songList
            text:"歌单"
            font.family: "楷体"
            font.pixelSize: 16
            Layout.rightMargin: 20
            MouseArea{
                anchors.fill: parent

                onClicked: {
                    subPage.source = "SubFrame_SongList.qml"
                    parent.font.bold = true
                    parent.font.pixelSize = 20
                    subframeSignal(preSubFrame, 2)
                }
            }
        }
        Text{
            id: leaderBoard
            text:"排行榜"
            font.family: "楷体"
            font.pixelSize: 16
            Layout.rightMargin: 20
            MouseArea{
                anchors.fill: parent

                onClicked: {
                    subPage.source = "SubFrame_Leaderboard.qml"
                    parent.font.bold = true
                    parent.font.pixelSize = 20
                    subframeSignal(preSubFrame, 3)
                }
            }
        }
        Text{
            id: singer
            text:"歌手"
            font.family: "楷体"
            font.pixelSize: 16
            Layout.rightMargin: 20
            MouseArea{
                anchors.fill: parent

                onClicked: {
                    subPage.source = "SubFrame_Singer.qml"
                    parent.font.bold = true
                    parent.font.pixelSize = 20
                    subframeSignal(preSubFrame, 4)
                }
            }
        }
        Text{
            id: latestMusic
            text:"最新音乐"
            font.family: "楷体"
            font.pixelSize: 16
            MouseArea{
                anchors.fill: parent

                onClicked: {
                    subPage.source = "SubFrame_LatestMusic.qml"
                    parent.font.bold = true
                    parent.font.pixelSize = 20
                    subframeSignal(preSubFrame, 5)
                }
            }
        }
    }

    ScrollView{
        width: parent.width
        height: parent.height - rowTextBtn.height -25
        contentHeight: subPage.height
        contentWidth: parent.width
        anchors.top: rowTextBtn.bottom
        anchors.topMargin: 20
        clip: true
        Loader{
            id: subPage
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 30
        }
        Connections{
            target: subPage.item
            function onSongList(id){
                mainWindow.currSonListId = id
//                console.log("DetailDiscover id:",mainWindow.currSonList)
                songListInDetailsDiscover(id)
            }
        }
    }
    Component.onCompleted: {
        preSubFrame = 0
        personalRecommendation.font.bold = true
        personalRecommendation.font.pixelSize = 20
        subPage.source = "SubFrame_PersonalRecommendation.qml"
    }
    onSubframeSignal: {
        if(curr != pre)
        {
            switch(pre){
            case 0:
                personalRecommendation.font.bold = false
                personalRecommendation.font.pixelSize = 16
                break
            case 1:
                exclusiveCustomization.font.bold = false
                exclusiveCustomization.font.pixelSize = 16
                break
            case 2:
                songList.font.bold = false
                songList.font.pixelSize = 16
                break
            case 3:
                leaderBoard.font.bold = false
                leaderBoard.font.pixelSize = 16
                break
            case 4:
                singer.font.bold = false
                singer.font.pixelSize = 16
                break
            case 5:
                latestMusic.font.bold = false
                latestMusic.font.pixelSize = 16
                break
            }
            preSubFrame = curr
        }
    }
}
