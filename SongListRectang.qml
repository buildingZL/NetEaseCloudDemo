import QtQuick 2.0
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.15
Rectangle{
    id: songListRectang

    property alias imageUrl:image.source
    property alias descriptionText: descriptionText.text
    property alias linecount: descriptionText.lineCount
    property var songListID
    signal songList(var songListId)

    Rectangle{
        id: imageRect
        width: parent.width
        height: width
        radius: 5
        Image{
            id: image
            anchors.fill: parent
            layer.enabled: true
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
            anchors.fill: imageRect
            hoverEnabled: true
            onEntered: {
                cursorShape = Qt.PointingHandCursor
            }
            onClicked:
            {
                console.log("songListId:"+songListID)
                songList(songListID)
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

        wrapMode: Text.WordWrap
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked:
            {
                songList(songListID)
            }
            onEntered: {
                cursorShape = Qt.PointingHandCursor
                parent.color = "black"
            }
            onExited: {
                parent.color = "#333333"
            }
        }
    }
}


