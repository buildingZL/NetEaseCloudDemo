import QtQuick 2.15
import QtQuick.Controls 2.5

Rectangle{
    id: middleViewLeftButton
    width:190
    height: 38
    radius: 3
    color: "transparent"
//    color: "#f6f6f7"
    property alias text: button.text
    property alias bold: contentText.font.bold
    property alias fontPixeSize: contentText.font.pixelSize

    Button{
        id:button
        anchors.fill: parent
        flat: true

        contentItem: Text{
            id: contentText
            text:parent.text
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
            font.family: "楷体"
        }
    }
}
