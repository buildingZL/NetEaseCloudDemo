import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.15

Rectangle{
    border.width: 1
    border.color: "#e0e0e0"
    property alias source:image.source
    property alias musicName: musicName.text
    property alias musicAuthor:musicAuthor.text
    property alias musicSlider:music_slider
    property alias musicStartTime:start_time
    property alias musicEndTime:end_time
    Rectangle{  //遮掉除上边框外的所有边框
        color: parent.color
        border.width: 0
        anchors.fill: parent
        anchors.topMargin: 1
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
    }

    Rectangle{ //music image
        id:imageSouce
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 12
        anchors.topMargin: 12
        width: 50
        height: 50
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
            id: mask
            anchors.fill: parent
            radius: 5
            visible: false
        }
    }

    Text{ //music name
        id: musicName
        width: 100
        height: 20
        text: "test"
        anchors.left: imageSouce.right
        anchors.leftMargin: 10
        anchors.top: imageSouce.top
        font.pixelSize: 16
        font.family: "楷体"
        elide: Text.ElideRight
    }
    Image {
        id: musicLiked
        source: "images/favorite.png"
        width:20
        height:20
        anchors.left: musicName.right
        anchors.leftMargin: 5
        anchors.top: musicName.top
    }
    Text{ //music author
        id: musicAuthor
        width: contentWidth
        height: 20
        text: "作者"
        anchors.left: musicName.left
        anchors.top: musicName.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
        font.family: "楷体"
    }
    Rectangle{ //按钮组
        width: 450
        height: parent.height
        anchors.centerIn: parent
        color:"transparent"
        Rectangle{
            id: list_loop_btn //循环播放
            width: 20
            height: 20
            anchors.verticalCenter: play_btn_rect.verticalCenter
            anchors.right: previous_btn.left
            anchors.rightMargin: 30

            Image {
                id: list_loop_image
                source: "images/list_loop.png"
                anchors.fill: parent
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                }
                onClicked: {
                }
            }
        }
        Rectangle{
            id: previous_btn //上一首
            width: 20
            height: 20
            anchors.verticalCenter: play_btn_rect.verticalCenter
            anchors.right: play_btn_rect.left
            anchors.rightMargin: 30

            Image {
                anchors.fill: parent
                source: "images/previous.png"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                }
                onClicked: {
                }
            }
        }

        Rectangle{
            id: play_btn_rect // 播放/暂停按钮
            width: 40
            height: 40
            radius: 20
            color: "#f5f5f5"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10

            Image {
                id: play_btn
                width: 20
                height: 20
                anchors.centerIn: parent
                source: "images/play_music.png"
                visible: mainWindow.player.playbackState == MediaPlayer.PausedState
                         || mainWindow.player.playbackState == MediaPlayer.StoppedState
                         ? true : false
            }
            Image {
                id: pause_btn
                width: 20
                height: 20
                anchors.centerIn: parent
                source: "images/pause_music.png"
                visible: mainWindow.player.playbackState == MediaPlayer.PlayingState ? true : false
            }
            MouseArea{
                id: play_btn_rect_mouse
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                    play_btn_rect.color = "#e1e1e1"
                }
                onExited: play_btn_rect.color="#f5f5f5"
                onClicked: {
                    if(mainWindow.player.playbackState == MediaPlayer.PlayingState){
                        mainWindow.player.pause()
                    }
                    else if(mainWindow.player.playbackState == MediaPlayer.PausedState){
                        mainWindow.player.play()
                    }
                    else{
                        mainWindow.player.source = mainWindow.currSongUrl.data[0].url
                        mainWindow.player.play()
                    }
                }
            }
        }
        Rectangle{
            id: next_music //下一首
            width: 20
            height: 20
            anchors.verticalCenter: play_btn_rect.verticalCenter
            anchors.left: play_btn_rect.right
            anchors.leftMargin: 30

            Image {
                id: next_music_image
                source: "images/next.png"
                anchors.fill: parent
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                }
                onClicked: {
                }
            }
        }
        Rectangle{
            id: lyric_btn //歌词按钮
            width: 20
            height: 20
            anchors.verticalCenter: play_btn_rect.verticalCenter
            anchors.left: next_music.right
            anchors.leftMargin: 30

            Image {
                id: lyric_image
                source: "images/lyric.png"
                anchors.fill: parent
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                }
                onClicked: {
                }
            }
        }
        Rectangle{
            width: parent.width
            height: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                id: start_time
                width: contentWidth
                height: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: music_slider.left
                anchors.rightMargin: 5
                text: "00:00"
            }
            Slider{ //播放进度
                id: music_slider
                width: parent.width - start_time.width - end_time.width - 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                from: 0
                to: mainWindow.player.duration
                value: mainWindow.player.position
                background: Rectangle {
                    x: music_slider.leftPadding
                    y: music_slider.topPadding + music_slider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 4
                    width: music_slider.availableWidth
                    height: implicitHeight
                    radius: 2
                    color: "#cecece"

                    Rectangle {
                        width: music_slider.visualPosition * parent.width
                        height: parent.height
                        color: "#ec4141"
                        radius: 2
                    }
                }

                handle: Rectangle {
                    x: music_slider.leftPadding + music_slider.visualPosition * (music_slider.availableWidth - width)
                    y: music_slider.topPadding + music_slider.availableHeight / 2 - height / 2
                    implicitWidth: 10
                    implicitHeight: 10
                    radius: 5
                    color: "#ec4141"
                }

                onValueChanged: {
                    start_time.text = mainWindow.millisecondConversion(mainWindow.player.position)
                    mainWindow.player.seek(value)
                }
            }
            Text{
                id: end_time
                width: contentWidth
                height: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: music_slider.right
                anchors.leftMargin: 5
                text: mainWindow.millisecondConversion(mainWindow.player.duration)
            }
        }
    }
    Rectangle{
        id: play_list_btn
        width: 20
        height: 20
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 30
        //        color: "red"
        Image{
            anchors.fill: parent
            source: "images/paly_list.png"
        }
    }
    Rectangle{ //音量
        id: volume_icon
        width: 20
        height: 20
        anchors.right: play_list_btn.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 30
        Image{
            anchors.fill: parent
            source: "images/24gl-volumeZero.png"
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cursorShape = Qt.PointingHandCursor
                volume_controlRect.visible = true
            }
        }
    }
    Rectangle{
        id: volume_controlRect
        width: 30
        height: 100
        anchors.bottom: volume_icon.top
        anchors.horizontalCenter: volume_icon.horizontalCenter
        visible: false
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.visible = true
            }
            onExited: {
                parent.visible = false
            }
        }

        Slider{
            id: volume_slider
            anchors.centerIn: parent
            width: 10
            height: 100
            from: 0
            to: 100
            stepSize: 1
            value: 100
            onValueChanged: {
                var vol = QtMultimedia.convertVolume(value / 100,
                                                     QtMultimedia.LinearVolumeScale,
                                                     QtMultimedia.LogarithmicVolumeScale)

                //                console.log("value:" + value + " volume:" + vol)
                mainWindow.player.volume = vol
            }

            orientation: Qt.Vertical

            background: Rectangle{
                x: volume_slider.leftPadding - width/2
                y: volume_slider.topPadding + volume_slider.availableHeight / 2 - height / 2
                implicitWidth: 4
                implicitHeight: 100
                width: implicitWidth
                height: volume_slider.availableHeight
                radius: 2
                color: "#ec4141"

                Rectangle {
                    width: 4
                    height: volume_slider.visualPosition * parent.height
                    color: "#cecece"
                    radius: 2
                }
            }

            handle: Rectangle {
                x: volume_slider.topPadding + volume_slider.availableWidth / 2 - width / 2
                y: volume_slider.leftPadding + volume_slider.visualPosition * (volume_slider.availableHeight - height)
                implicitWidth: 10
                implicitHeight: 10
                radius: 5
                color: "#ec4141"
            }
        }
    }
}
