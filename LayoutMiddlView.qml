import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item{
    property var qmlList: [
        {value:"发现音乐", qml:"DetailsDiscoverQml.qml"},
        {value:"播客", qml:"DetailsPodcastQml.qml"},
        {value:"视频", qml:"DetailsVideoQml.qml"},
        {value:"关注", qml:"DetailsFollowQml.qml"},
        {value:"直播", qml:"DetailsLiveBroadcastQml.qml"},
        {value:"私人FM", qml:"DetailsPrivatePersonQml.qml"},
    ]

    property var qmlList_bottom: [
        {icon:"images/favorite.png", value:"我喜欢的音乐", qml:"DetailsMyLikeMusicQml.qml"},
        {icon:"images/download.png", value:"本地与下载", qml:"DetailsLocalMusicQml.qml"},
        {icon:"images/recently_played.png", value:"最近播放", qml:"DetailsRecentlyPlayedQml.qml"}
    ]
    property var currPage


    Rectangle{
        id: middleview
        width:200
        height: parent.height

        Rectangle{
            width: 200
            height: parent.height
            border.color: "#e0e0e0"
            border.width: 1

            Rectangle{
                color: parent.color
                border.width: 0
                anchors.fill: parent
                anchors.topMargin: 0
                anchors.rightMargin: 1
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
            }

            Column{
                anchors.fill: parent
                leftPadding:10
                spacing: 3

                Item{
                    width: parent.width
                    height: 10
                }


                Repeater{
                    id:leftButtonRepeater
                    model: qmlList
                    LayoutMiddleLeftButton{
                        text: qmlList[index].value

                        MouseArea{
                            id: mouseBtn
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {

                                if(currPage < 6)
                                {
                                    if(currPage !== index)
                                    {
                                        loader.source = qmlList[index].qml
                                        leftButtonRepeater.itemAt(index).color = "#f6f6f7"
                                        leftButtonRepeater.itemAt(index).bold = true
                                        leftButtonRepeater.itemAt(index).fontPixeSize = 20

                                        leftButtonRepeater.itemAt(currPage).color = "transparent"
                                        leftButtonRepeater.itemAt(currPage).bold = false
                                        leftButtonRepeater.itemAt(currPage).fontPixeSize = 16
                                        currPage = index
                                    }
                                }
                                if(currPage >= 6)
                                {
                                    iconButtonRepeater.itemAt(currPage % 6).color = "transparent"

                                    loader.source = qmlList[index].qml
                                    leftButtonRepeater.itemAt(index).color = "#f6f6f7"
                                    leftButtonRepeater.itemAt(index).bold = true
                                    leftButtonRepeater.itemAt(index).fontPixeSize = 20

                                    currPage = index
                                }
                                //console.log(parent.text + "clicked:" + currPage)
                            }
                            onEntered: {
                                leftButtonRepeater.itemAt(index).color = "#f6f6f7"
                            }
                            onExited: {
                                if(currPage < 6)
                                    if(currPage !== index)
                                        leftButtonRepeater.itemAt(index).color = "transparent"
                                if(currPage >= 6)
                                    leftButtonRepeater.itemAt(index).color = "transparent"
                            }
                        }
                    }
                }

                Rectangle{
                    width:190
                    height: 38
                    color: "transparent"
                    Text {
                        font.family: "楷体"
                        font.pixelSize: 14
                        text: "我的音乐"
                        color: "#dbbbce"
                        leftPadding: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Repeater{
                    id: iconButtonRepeater
                    model: qmlList_bottom

                    LayoutMiddleLeftIconButton{
                        text: qmlList_bottom[index].value
                        source: qmlList_bottom[index].icon

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {

                                if(currPage >= 6)
                                {
                                    if((currPage % 6) !== index)
                                    {
                                        loader.source = qmlList_bottom[index].qml
                                        iconButtonRepeater.itemAt(index).color = "#f6f6f7"
                                        iconButtonRepeater.itemAt(currPage % 6).color = "transparent"
                                        currPage = index + 6
                                    }
                                }
                                if(currPage < 6)
                                {
                                    leftButtonRepeater.itemAt(currPage).color = "transparent"
                                    leftButtonRepeater.itemAt(currPage).bold = false
                                    leftButtonRepeater.itemAt(currPage).fontPixeSize = 16

                                    loader.source = qmlList_bottom[index].qml
                                    leftButtonRepeater.itemAt(currPage).color = "transparent"
                                    currPage = index + 6
                                }
                                //console.log(parent.text + "clicked:" + currPage)
                            }
                            onEntered: {
                                iconButtonRepeater.itemAt(index).color = "#f6f6f7"
                            }
                            onExited: {
                                if(currPage < 6)
                                    iconButtonRepeater.itemAt(index).color = "transparent"
                                if(currPage >= 6)
                                    if(currPage % 6 !== index)
                                        iconButtonRepeater.itemAt(index).color = "transparent"
                            }
                        }
                    }
                }
            }
        }
        Component.onCompleted: {
            loader.source = qmlList[0].qml
            currPage = 0
            leftButtonRepeater.itemAt(0).bold = true
            leftButtonRepeater.itemAt(0).fontPixeSize = 18
            leftButtonRepeater.itemAt(0).color = "#f6f6f7"
        }
    }

    Loader{
        id: loader
        width: parent.width - middleview.width
        height: parent.height
        anchors.left: middleview.right
        anchors.top: middleview.top
        clip: true
    }

    Connections{
        target: loader.item
        function onSongListInDetailsDiscover(id){
//            console.log("Connections:"+id)
            if (loader.status === Loader.Ready) {
                var loadedComponent = loader.item
                if (loadedComponent) {
                    loader.source = "SongListFrame.qml"
                    var page = loader.item

                }
            }
        }
    }
}
