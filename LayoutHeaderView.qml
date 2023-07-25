import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15


Rectangle{
    property var dragPosition: Qt.point(0,0)

    id: headerView

    implicitWidth: parent.width
    implicitHeight: 50
    color: "#ec4141"

    MouseArea{
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            dragPosition = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged:{
            var newPos = Qt.point(mainWindow.x + mouse.x - dragPosition.x,
                                  mainWindow.y + mouse.y - dragPosition.y)
            mainWindow.setX(newPos.x)
            mainWindow.setY(newPos.y)
        }
    }

    Rectangle{
        id: logIcon
        width: logimage.width + logtext.contentWidth + logimage.anchors.leftMargin
        height:32
        color: "transparent"
        anchors.verticalCenter: headerView.verticalCenter
        anchors.left: headerView.left
        anchors.leftMargin: 20

        Image {
            id: logimage
            source: "qrc:/images/music.png"
            width:25
            height:25
            anchors.verticalCenter: logIcon.verticalCenter
        }
        Text{
            id:logtext
            text: "NetEase Cloud"
            color:"white"
            anchors.left: logimage.right
            anchors.verticalCenter: logimage.verticalCenter
            anchors.leftMargin: 5
            font.pixelSize: 20
            font.family: "Microsoft YaHei UI"
        }
    }

    Rectangle{
        height: 25
        width: 60
        anchors.left: logIcon.right
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Rectangle{
            id: advanceRect
            width: 25
            height: 25
            anchors.left: parent.left
            radius: width /2
            color: "#d93c3c"
            Image{
                width: 10
                height: 10
                anchors.centerIn: parent
                source: "images/recoil.png"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled : true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }
            }
        }

        Rectangle{
            id: recoilRect
            width: 25
            height: 25
            anchors.right: parent.right
            radius: width /2
            color: "#d93c3c"
            Image{
                width: 10
                height: 10
                anchors.centerIn: parent
                source: "images/advance.png"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled : true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }
            }
        }

    }

    Rectangle{
        id: searchRectangle
        width: 160
        height: 32
        anchors.verticalCenter: headerView.verticalCenter
        anchors.left: logIcon.right
        anchors.leftMargin: 130
        color: "#e33e3e"
        radius: 16

        Rectangle{
            id: searchImage
            width: 32
            height: 32
            color: "transparent"
            anchors.verticalCenter: searchRectangle.verticalCenter

            Button {
                property color normalcolor : "white"
                property color hoveredcolor: "#f4b2b2"

                id: searchbtn
                width:32
                height:32
                flat: true
                icon.source: "qrc:/images/search.png"
                icon.width: 16
                icon.height: 16
                icon.color: normalcolor
                anchors.verticalCenter: searchImage.verticalCenter
                anchors.left: searchImage.left
                anchors.leftMargin: 5
                onHoveredChanged: {
                    searchbtn.hovered ? icon.color = hoveredcolor : icon.color = normalcolor
                }
                MouseArea{
                    anchors.fill: searchbtn
                    onClicked: {
                        searchbtn.focus = true
                        console.log("searchbtn clicked")
                    }
                }
            }
        }

        Rectangle{
            id: searchInputTextRectangle
            width: parent.width - searchImage.width - 5
            height: 32
            color: "transparent"
            anchors.verticalCenter: searchRectangle.verticalCenter
            anchors.left: searchImage.right
            anchors.leftMargin: 5
            TextInput{
                id: searchInputText
                anchors.fill: parent
                anchors.verticalCenter: searchInputTextRectangle.verticalCenter
                verticalAlignment: TextInput.AlignVCenter
                text: "test"
                clip: true
                color: "white"
                font.pixelSize: 14
                font.family: "微软雅黑"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        searchInputText.focus = true
                        console.log("TextInput clicked")
                    }
                }
            }
        }
    }

    Item {
        id:item
        Layout.fillHeight: true // 填充剩余的空白区域
    }
    Rectangle{
        width: 32 * 3 + 2 * 10
        height: 32
        anchors.right: headerView.right
        anchors.verticalCenter: headerView.verticalCenter
        color: "transparent"
        Row{
            Button{
                width:32
                height:32
                icon.source: "qrc:/images/min_screen.png"
                icon.color: "white"
                flat: true
                onClicked: mainWindow.visibility = Window.Minimized
                ToolTip.text: "最小化"
                ToolTip.visible: hovered
                ToolTip.delay: 1000
            }
            Rectangle{
                width:32
                height:32
                color:"transparent"
                Button{
                    id: maxbtn
                    anchors.fill: parent
                    icon.source: "qrc:/images/max_screen.png"
                    icon.color: "white"
                    flat: true
                    ToolTip.text: "最大化"
                    ToolTip.visible: hovered
                    ToolTip.delay: 1000

                    onClicked: {
                        mainWindow.visibility = Window.Maximized
                        restorebtn.visible = true
                        maxbtn.visible = false
                    }
                }
                Button{
                    id: restorebtn
                    anchors.fill: parent
                    icon.source: "qrc:/images/restore.png"
                    icon.color: "white"
                    flat: true
                    visible: false
                    ToolTip.text: "恢复窗口"
                    ToolTip.visible: hovered
                    ToolTip.delay: 1000

                    onClicked: {
                        mainWindow.visibility = Window.AutomaticVisibility
                        maxbtn.visible = true
                        restorebtn.visible = false
                    }
                }
            }
            Button{
                width:32
                height:32
                icon.source: "qrc:/images/power.png"
                icon.color: "white"
                flat: true
                ToolTip.text: "关闭"
                ToolTip.visible: hovered
                ToolTip.delay: 1000
                onClicked: Qt.quit()
            }
        }
    }
}
