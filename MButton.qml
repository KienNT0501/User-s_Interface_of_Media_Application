import QtQuick 2.0

MouseArea {
    id: rootId
    property string icon_pressed: ""
    property string icon_released: ""
    property string icon_default: ""
    property var widthItem
    property var heightItem
    property string buttonType
    signal nextButton()

    implicitWidth: img.width
    implicitHeight: img.height
    Image {
        id: img
        source: rootId.icon_default
        width: rootId.widthItem
        height: rootId.heightItem
    }
    onPressed: {
        img.source = icon_pressed

    }
    onReleased: {
        img.source = icon_released
        if(buttonType === "prev"){
           player.previous()
           player.onoffState(false)
        }
        if(buttonType === "next"){
           player.next()
           player.onoffState(false)

        }
    }
    Connections{
        target: player
        onCurrentIndexChanged: {
            album_art_view.currentIndex = index;
        }
}
}
