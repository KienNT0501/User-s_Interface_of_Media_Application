import QtQuick 2.0
import QtQuick.Controls 2.5
import QtMultimedia 5.2
Item {
    property bool isRunning:false
    property bool isReturning:false
    property int artViewIndex
    anchors.fill:parent
    MButton{
        id: nextbuttonId
        anchors.verticalCenter: playbuttonId.verticalCenter
        anchors.left:playbuttonId.right
        buttonType: "next"
        heightItem: 40
        widthItem: 65
        icon_default: "qrc:/Image/next.png"
        icon_pressed: "qrc:/Image/hold-next.png"
        icon_released: "qrc:/Image/next.png"
    }
    MButton{
        id:prevbuttonId
        anchors.verticalCenter: playbuttonId.verticalCenter
        anchors.right:playbuttonId.left
        heightItem: 40
        widthItem: 65
        buttonType: "prev"
        icon_default: "qrc:/Image/prev.png"
        icon_pressed: "qrc:/Image/hold-prev.png"
        icon_released: "qrc:/Image/prev.png"
    }
    OnOffButton{
        id:shufflebuttonId
        anchors.verticalCenter: playbuttonId.verticalCenter
        //anchors.left :parent.left
        //anchors.leftMargin: 130
        x:70
        heightItem: 35
        widthItem: 70
        buttonType: "shuffle"
        icon_default: "qrc:/Image/shuffle.png"
        icon_pressed: "qrc:/Image/shuffle-1.png"
        icon_released: "qrc:/Image/shuffle.png"
    }
    OnOffButton{
        id:replaybuttonId
        anchors.verticalCenter: playbuttonId.verticalCenter
        anchors.right :parent.right
        anchors.rightMargin: 80
        heightItem: 35
        widthItem: 70
        icon_default: "qrc:/Image/repeat.png"
        icon_pressed: "qrc:/Image/repeat1_hold.png"
        icon_released: "qrc:/Image/repeat.png"
        buttonType: "replay"
    }
    SwitchButton{
        id: playbuttonId
        x:580
        y:600
        heightItemsw:80
        widthItemsw: 80
        icon_defaultsw: "qrc:/Image/pause.png"
        icon_pressedsw1: "qrc:/Image/hold-pause.png"
        icon_releasedsw1: "qrc:/Image/pause.png"
        icon_pressedsw2: "qrc:/Image/hold-play.png"
        icon_releasedsw2: "qrc:/Image/play.png"
    }
    PropertyAnimation{
        id:animationBackId
        target:playbuttonId
        property: "x"
        to:550
        running: isReturning
        duration: 100
        onStopped: {
            isReturning = false
        }
    }
    PropertyAnimation{
        id:animationGoId
        target:playbuttonId
        property: "x"
        to:790
        running: isRunning
        duration: 100
        onStopped: {
            isRunning = false
        }
    }
    PropertyAnimation{
        id:animationBackartId
        target:album_art_view
        property: "x"
        to:170
        running: isReturning
        duration: 100
        onStopped: {
            isReturning = false
        }
    }
    PropertyAnimation{
        id:animationGoartId
        target:album_art_view
        property: "x"
        to:420
        running: isRunning
        duration: 100
        onStopped: {
            isRunning = false
        }
    }
    PropertyAnimation{
        id:animationBacktextId
        target:labelMusicTiltle
        property: "x"
        to:0
        running: isReturning
        duration: 100
        onStopped: {
            isReturning = false
        }
    }
    PropertyAnimation{
        id:animationGotextId
        target:labelMusicTiltle
        property: "x"
        to:playlistId.width+90
        running: isRunning
        duration: 100
        onStopped: {
            isRunning = false
        }
    }
    Text{
        id: labelMusicTiltle
        text: PlaylistModel.d_data(album_art_view.currentIndex,0)
        color:"white"
        font.pointSize: 18
        font.family: "Calibri"
        x:55
        anchors.top: parent.top
        anchors.topMargin: headerItem.height+10
        onTextChanged: {
            textChangeAni.targets = [labelMusicTiltle,labelSinger]
            textChangeAni.restart()
        }
    }
    Text{
        id: labelSinger
        text:  PlaylistModel.d_data(album_art_view.currentIndex,1)
        color:"white"
        font.pointSize: 16
        font.family: "Calibri"
        anchors.left:labelMusicTiltle.left
        anchors.top : labelMusicTiltle.bottom
    }
    NumberAnimation {
        id: textChangeAni
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
    PropertyAnimation{
        id:progressbaroniId
        target:progressBar
        property: "width"
        to:520
        running: isRunning
        duration: 100
        onStopped: {
            isRunning = false
        }
    }
    PropertyAnimation{
        id:progressbaroffiId
        target:progressBar
        property: "width"
        to:1055
        running: isReturning
        duration: 100
        onStopped: {
            isReturning = false
        }
    }PropertyAnimation{
        id:shufflebuttonGoId
        target:shufflebuttonId
        property: "x"
        to:480
        running: isRunning
        duration: 100
        onStopped: {
            isRunning = false
        }
    }
    PropertyAnimation{
        id:shufflebuttonBackId
        target:shufflebuttonId
        property: "x"
        to:75
        running: isReturning
        duration: 100
        onStopped: {
            isReturning = false
        }
    }
    Slider{
        id: progressBar
        anchors.right:parent.right
        anchors.rightMargin: 110
        x:150
        y:550
        width: 990
        from: 0
        stepSize: 1000
        //to: player.duration
        pressed:true
        value: player.c_position
        background: Rectangle {
            x: progressBar.leftPadding
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            implicitWidth: 600
            implicitHeight: 3
            width: progressBar.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"
            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            source: "qrc:/Image/point.png"
            height:18
            width:18
            Image {
                anchors.centerIn: parent
                source: "qrc:/Image/center_point.png"
                height:12
                width:12
            }
        }
        property real lastDraggedValue:0
        onMoved: {
                lastDraggedValue = value;

        }
        onPressedChanged: {
            if(!pressed)player.seek(lastDraggedValue)
            console.log("Press release!")
        }
    }
    Image{
        id:musicIcondid
        source:"qrc:/Image/music.png"
        anchors.right:parent.right
        anchors.rightMargin: 35
        anchors.top: parent.top
        anchors.topMargin: headerItem.height+20
        height:25
        width:25
    }
    Text{
        id:labelNumberofMusic
        text: PlaylistModel.rowCount()
        font.pointSize: 16
        color:"white"
        font.family: "Calibri"
        anchors.bottom:musicIcondid.bottom
        anchors.left:musicIcondid.right
        anchors.leftMargin: 5
    }

    Text{
        id:currentTimeId
        //anchors.left: parent.left
        //anchors.leftMargin: 120
        anchors.right: progressBar.left
        anchors.rightMargin: 5
        y: progressBar.y+12
        text: player.updateCurrentPosition(player.c_position)
        font.pointSize: 10
        color:"white"
        font.family: "Calibri"
    }

    Text{
        id:stopTime
        anchors.right: parent.right
        anchors.rightMargin: 75
        y: currentTimeId.y
        text: "00:00"
        font.pointSize: 10
        color:"white"
        font.family: "Calibri"

    }
    PathView {
        id: album_art_view
        x:200
        y:50
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: PlaylistModel
        delegate: Item{
            width: 300; height: 300
            scale: PathView.iconScale

            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20; anchors.horizontalCenter: parent.horizontalCenter
                source: imageSource
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    album_art_view.currentIndex = index
                    player.jumpTomedia(index);
                }
            }
        }
        pathItemCount:3
        path: Path {
            startX: 55
            startY: 250
            PathAttribute { name: "iconScale"; value: 0.4 }
            PathLine { x: 380; y: 250 }
            PathAttribute { name: "iconScale"; value: 0.9 }
            PathLine { x: 760; y: 250 }
            PathAttribute { name: "iconScale"; value: 0.4 }
        }
        onCurrentIndexChanged: {
            player.onoffState(false)
            player.start()
        }

        }
    Connections{
        target: player
        onCurrentIndexChanged: {
            album_art_view.currentIndex = index;
        }
        onDisplayChanged:{
           stopTime.text = s
        }
        onDurationChanged:{
            progressBar.to = val
        }
}
}


