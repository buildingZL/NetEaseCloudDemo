WorkerScript.onMessage = function(jsobj){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if(xhr.readyState === 4){
            var messageobj ={}
            messageobj.index = jsobj.index
            messageobj.time = JSON.parse(xhr.responseText).data[0].time
            WorkerScript.sendMessage(messageobj)
        }
    }
    xhr.open("get", "http://localhost:3000/song/url/v1?id=" + jsobj.songId + "&level=exhigh", false)
    xhr.send()
}
