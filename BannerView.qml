import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: bannerView
    width: parent.width
    height: parent.height
    property alias bannerList : pathView.model

    PathView{
        id: pathView
        width: parent.width
        height: 200
        clip: true
        pathItemCount: 3
        path:bannerPath
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        delegate:Rectangle{
            id: bannerLeftImage
            width: 540
            height: 200
            z:PathView.pathZ ? PathView.pathZ : 0
            scale: PathView.pathScale ? PathView.pathScale : 1
            radius: 3

            Image{
                width: parent.width
                height: parent.height
                source: modelData.imageUrl
                anchors.horizontalCenter: parent.horizontalCenter
                layer.enabled: true
                layer.effect: OpacityMask{
                    anchors.fill: parent
                    maskSource: mask
                }
            }
            Rectangle{
                id: mask
                anchors.fill: parent
                radius: 5
                visible: false
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    if(index !== pathView.currentIndex)
                    {
                        pathView.currentIndex = index
                    }
                }
                onEntered: {
                    timer.stop()

                }
                onExited: {
                    timer.restart()
                }
            }
        }
    }

    Path{
        id:bannerPath
        startX: 0
        startY: pathView.height/2

        PathAttribute{name:"pathZ";value:0.0}
        PathAttribute{name:"pathScale";value:0.6}

        PathLine{
            x:pathView.width/2
            y:pathView.height/2
        }

        PathAttribute{name:"pathZ";value:2.0}
        PathAttribute{name:"pathScale";value:1}

        PathLine{
            x:pathView.width
            y:pathView.height/2
        }

        PathAttribute{name:"pathZ";value:0.0}
        PathAttribute{name:"pathScale";value:0.6}
    }

    PageIndicator{
        id: indicator
        anchors{
            top: pathView.bottom
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }

        count: pathView.count
        currentIndex: 0
        delegate: Rectangle{
            implicitWidth: 6
            implicitHeight: 6

            radius: width/2
            color: index === pathView.currentIndex ? "#ec4141" : "#cecece"

            Behavior on color{
                ColorAnimation{
                    duration: 200
                }
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    pathView.currentIndex = index
                }
            }
        }
    }
    Timer{
        id: timer
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            if(pathView.currentIndex == pathView.count + 1)
            pathView.currentIndex = 0
            else
                pathView.currentIndex = pathView.currentIndex + 1
        }
    }
}
