import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.15
import Qt.labs.qmlmodels 1.0

ScrollView {
    width: parent.width
    height: parent.height
    contentHeight: imageRect.height + descriptionRect.height + tableView.height + 50
    property var songlist
    property var allSongDetailedInfomation
    property var songDetails:[]
    property var songDetalsTime:[]
    Rectangle{
        id: imageRect
        width: 186
        height: 186
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30

        Image{
            id: image
            anchors.fill: parent
            source: songlist ? songlist.playlist.coverImgUrl : ""
            layer.enabled: true
            layer.effect: OpacityMask{
                anchors.fill: parent
                maskSource: mask
            }
        }
        Rectangle{
            id: mask
            anchors.fill: parent
            visible: false
            radius: 5
        }
    }


    Rectangle{
        id: songList_tag
        width: 40
        height: 20
        radius: 3
        border.color: "red"
        border.width: 1
        anchors.left: imageRect.right
        anchors.leftMargin: 20
        anchors.top: imageRect.top
        Text {
            text: "歌单"
            font.pixelSize: 16
            font.family: "楷体"
            color: "red"
            anchors.centerIn: parent
        }
    }
    Text {  //歌单名字
        id: songListName
        font.pixelSize: 20
        font.family: "楷体"
        text: songlist ? songlist.playlist.name : ""
        anchors.left: songList_tag.right
        anchors.leftMargin: 10
        anchors.verticalCenter: songList_tag.verticalCenter
        anchors.horizontalCenter: songList_tag.horizontalCenter
    }

    Text{
        id:tagsText
        height: 14
        font.pixelSize: 14
        font.family: "楷体"
        text: songlist ? "标签:" + songlist.playlist.tags : ""
        anchors.left: songList_tag.left
        anchors.top: songListName.bottom
        anchors.topMargin: 30
    }
    Text{
        id: trackCountText
        height: 14
        font.pixelSize: 14
        font.family: "楷体"
        text: songlist ? "歌曲:" + songlist.playlist.trackCount : ""
        anchors.left: songList_tag.left
        anchors.top: tagsText.bottom
        anchors.topMargin: 30
    }

    Rectangle{
        id: descriptionRect
        property bool fold: false
        width: parent.width
        height: 16
        anchors.left: trackCountText.left
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: imageRect.top
        anchors.topMargin: imageRect.height - 16
        Text{
            id: descriptionText
            width: parent.width - 16
            height: parent.height
            font.pixelSize: 16
            font.family: "楷体"
            text: songlist ? songlist.playlist.description : ""
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
            onContentHeightChanged: {
                if(descriptionRect.fold && descriptionText.elide == Text.ElideNone) descriptionRect.height = contentHeight
            }
        }
        Rectangle{
            width: 16
            height: 16
            anchors.right: parent.right
            anchors.top: parent.top
            Image{
                id: descriptionImage
                anchors.fill: parent
                source: "/images/unfold.png"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    descriptionRect.fold = !descriptionRect.fold
                    if(descriptionRect.fold)    //如果为真，展开
                    {
                        descriptionImage.source = "/images/fold.png"
                        descriptionText.elide = Text.ElideNone
                        descriptionRect.height = descriptionText.contentHeight
                    }
                    else    //如果为假，折叠
                    {
                        descriptionImage.source = "/images/unfold.png"
                        descriptionText.elide = Text.ElideRight
                        descriptionRect.height = 16
                    }
                }
            }
        }
    }


    Rectangle{
        width: parent.width
        height: tableHeaderView.height + tableView.height
        anchors.top: descriptionRect.bottom
        anchors.topMargin: 20
        HorizontalHeaderView{
            id: tableHeaderView
            width: parent.width
            height: 35
            anchors.top: parent.top
            anchors.left: parent.left
            syncView: tableView
            model: headerModel
            textRole: "header"
            delegate:Rectangle{
                implicitHeight: 35
                implicitWidth: 100
                Text{
                    anchors.fill: parent
                    font.pixelSize: 14
                    font.family: "微软雅黑"
                    horizontalAlignment: column === 0 ? Text.AlignHCenter : Text.AlignLeft
                    text: modelData
                }
            }
        }
        ListModel {
            id: headerModel
            ListElement { header: "序号" }
            ListElement { header: "操作" }
            ListElement { header: "标题" }
            ListElement { header: "歌手" }
            ListElement { header: "专辑" }
            ListElement { header: "时间" }
        }
        TableView{
            id: tableView
            width: tableHeaderView.width
            height: contentHeight + 35
            anchors.top: tableHeaderView.bottom
            property var columWidths:[0.1, 0.1, 0.4, 0.2, 0.1, 0.1]
            columnWidthProvider: function(column) {return columWidths[column] *width}
            rowHeightProvider: function(row) { return 35 }
            model: TableModel{
                id: listmodel
                TableModelColumn{display: "index"}
                TableModelColumn{display: "operate"}
                TableModelColumn{display: "title"}
                TableModelColumn{display: "singer"}
                TableModelColumn{display: "album"}
                TableModelColumn{display: "time"}
            }
            delegate:Rectangle{
                implicitWidth: tableView.columnWidthProvider(column)
                implicitHeight: tableView.rowHeightProvider(row)
                color: row % 2 == 0 ? "#fafafa" : "#ffffff"
                Text{
                    anchors.fill: parent
                    horizontalAlignment: column === 0 ? Text.AlignHCenter : Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: display
                    font.pixelSize: 12
                    font.family: "微软雅黑"
                    elide: Text.ElideRight
                    color: column === 2 ? "black" : "#b5b5b5"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onDoubleClicked: {
                        mainWindow.currSongId = allSongDetailedInfomation[row].id
                    }

                    onEntered: {
                        parent.color = "#f2f2f3"
                    }
                    onExited: {
                        parent.color = row % 2 == 0 ? "#fafafa" : "#ffffff"
                    }
                }
            }
        }
    }


    WorkerScript{
        id: workscript
        source: "workerScript.js"
        onMessage: {
            var index = listmodel.index(messageObject.index, 5);
            listmodel.setData(index, "display", millisecondConversion(messageObject.time));
        }
    }


    Component.onCompleted: {
        getSongListDetails()
    }

    function getSongListDetails(){  //歌单信息

        function onReply(reply){
            mainWindow.http.onReplySignal.disconnect(onReply)
            songlist = JSON.parse(reply)
            getAllSongOfSongList()
        }

        mainWindow.http.onReplySignal.connect(onReply);
        mainWindow.http.connet("playlist/detail?id=" + mainWindow.currSonListId);
    }

    function getAllSongOfSongList(){    //歌单所有歌曲id
        function onReply(reply){
            mainWindow.http.onReplySignal.disconnect(onReply)
            allSongDetailedInfomation = JSON.parse(reply).songs
            for (var i = 0; i < allSongDetailedInfomation.length; i++) {
                listmodel.appendRow({
                                        "index": i + 1,
                                        "operate": "Operate",
                                        "title":    allSongDetailedInfomation[i].name,
                                        "singer":   allSongDetailedInfomation[i].ar[0].name,
                                        "album":    allSongDetailedInfomation[i].al.name,
                                        "time": "time"
                                    })
                var obj = {}
                obj.index = i
                obj.songId = allSongDetailedInfomation[i].id
                workscript.sendMessage(obj)
            }
        }
        mainWindow.http.onReplySignal.connect(onReply);
        mainWindow.http.connet("playlist/track/all?id=" + mainWindow.currSonListId);
    }

    function millisecondConversion(ms)
    {
        var seconds = Math.floor(ms / 1000);
        var minutes = Math.floor(seconds / 60);
        var hours = Math.floor(minutes / 60);

        var milliseconds = ms % 1000;
        seconds = seconds % 60;
        minutes = minutes % 60;

        function hoursIsTrue(){
            var timeFormat = hours.toString().padStart(2, '0') + ":" +
                    minutes.toString().padStart(2, '0') + ":" +
                    seconds.toString().padStart(2, '0');
            return timeFormat
        }

        function hoursIsFalse(){
            var timeFormat = minutes.toString().padStart(2, '0') + ":" +
            seconds.toString().padStart(2, '0');
            return timeFormat
        }

        var timeFormat = hours ? hoursIsTrue() : hoursIsFalse();
        return timeFormat;
    }
}
