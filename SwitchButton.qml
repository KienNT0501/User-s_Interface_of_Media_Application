import QtQuick 2.0

MouseArea {
    id: rootIdsw
    property string icon_pressedsw1: ""
    property string icon_releasedsw1: ""
    property string icon_pressedsw2: ""
    property string icon_releasedsw2: ""
    property string icon_defaultsw: ""
    property var widthItemsw
    property var heightItemsw
    property bool status: true
    signal playSignal()
    signal stopSignal()
    implicitWidth: imgsw.width
    implicitHeight: imgsw.height
    Image {
        id: imgsw
        source: rootIdsw.icon_defaultsw
        width: rootIdsw.widthItemsw
        height: rootIdsw.heightItemsw
    }
    function converter(){
        if(imgsw.source =  icon_releasedsw1){
        imgsw.source =  icon_releasedsw2
        status = 1-status
        }
    }
    onPressed: {
        if(status===true){
            imgsw.source = icon_pressedsw1
        }
        else{
            imgsw.source = icon_pressedsw2
        }
    }

    onReleased: {
        if(status==true){
            player.onoffState(false)
             player.stop()
            imgsw.source = icon_releasedsw2
            //console.log("Dung")
            stopSignal()

             //player.setPlayMedia(status)
        }
        else{
             player.onoffState(true)
             player.start()
            imgsw.source = icon_releasedsw1
            //console.log("Choi" + status)
            playSignal()

            //player.setPlayMedia(status)
        }

        status = 1-status
    }
    Connections{
        target:player
        onCurrentMediaChanged: converter();
    }

}
