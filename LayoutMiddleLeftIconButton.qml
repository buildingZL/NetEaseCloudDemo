import QtQuick 2.15
import QtQuick.Controls 2.5

Rectangle{
    id: middleViewLeftIconButton
    width:190
    height: 38
    radius: 3
    color: "transparent"
    property alias text:text.text
    property alias source:imageSource.source
    Button{
        id: iconButton
        anchors.fill: parent
        flat:true

        contentItem: Item{
            id:rect
            anchors.fill: iconButton
            Image{
                id:imageSource
                width: 16
                height:16
                anchors.left: rect.left
                anchors.verticalCenter: rect.verticalCenter
                anchors.leftMargin:10
            }
            Text{
                id: text
                width:parent.width - imageSource.width - 13
                height: 16
                anchors.left: imageSource.right
                anchors.verticalCenter: rect.verticalCenter
                anchors.leftMargin: 3
                font.pixelSize: 16
                font.family: "楷体"
            }
        }
    }
}
