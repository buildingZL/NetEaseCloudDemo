import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import NetworkUtil 1.0
import QtMultimedia 5.15

Window {
    id: mainWindow

    property var currSonListId //当前歌单id
    property var currSongId   //当前歌曲id
    property var currSongUrl //当前歌曲播放url
    property var currSongDetails //当前歌曲详情
    property int currPage : 0 //当前页面
    property var historyPage : [ //历史页面
        {detailsPage:"DetailsDiscoverQml.qml", subPage:"SubFrame_PersonalRecommendation.qml"}
    ]
    property alias http:http
    property alias player:playMusic
    signal dispacher(string detailPage, string subPage)  //信号分发器

    width: 1022
    height: 670

    x:100
    y:50
    flags: Qt.FramelessWindowHint | Qt.Window
    visible: true

    HttpUtils{
        id: http
    }
    MediaPlayer {
        id: playMusic
    }


    ColumnLayout{
        anchors.fill: parent
        LayoutHeaderView{
            id:headerView
            Layout.fillWidth: true
            Layout.preferredHeight: 60
        }

        LayoutMiddlView{
            id: middlView
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        LayoutBottomView{
            id: bottomView
            Layout.fillWidth: true
            Layout.preferredHeight: 74
            source: "images/test.jpg"
        }
    }

    onCurrSongIdChanged: {  //获取歌曲详细信息
        console.log(currSongId)
        getSongUrl(currSongId)
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function(){
            if(xhr.readyState === 4){
                currSongDetails = JSON.parse(xhr.responseText.toString())
                bottomView.source = currSongDetails.songs[0].al.picUrl
                bottomView.musicName = currSongDetails.songs[0].name
                bottomView.musicAuthor = currSongDetails.songs[0].ar[0].name
            }
        }
        xhr.open("get", "http://localhost:3000/song/detail?ids=" + currSongId, false)
        xhr.send()
    }

    function getSongUrl(songid) //获取歌曲播放地址url
    {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function(){
            if(xhr.readyState === 4){
                var songdetail = JSON.parse(xhr.responseText.toString())
                currSongUrl = songdetail
                player.source = songdetail.data[0].url
                player.play()
            }
        }
        xhr.open("get", "http://localhost:3000/song/url/v1?id=" + songid + "&level=exhigh", false)
        xhr.send()
    }

    function onDispacher(detailPage,subPage){
        var newobj = {detailsPage:detailPage, subPage:subPage}
        historyPage.push(newobj)
        currPage += 1
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

    Component.onCompleted: {
        dispacher.connect(onDispacher)
        dispacher("1","2")
    }
    //    function goBack() {
    //        if (historyPage.length > 1) {
    //            // 移除当前页面的历史记录
    //            historyPage.pop();

    //            // 获取上一个页面的信息
    //            var previousPage = historyPage[historyPage.length - 1];

    //        }
    //    }

    //    function goForward() {
    //        if (historyPage.length < 2) {
    //            return; // 无法前进
    //        }

    //        // 获取下一个页面的信息
    //        var nextPage = historyPage[historyPage.length - 2];

    //    }
}
