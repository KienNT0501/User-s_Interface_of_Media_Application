import QtQuick 2.0

MouseArea {
    id: rootId
    property string icon_pressed: ""
    property string icon_released: ""
    property string icon_default: ""
    property var widthItem
    property var heightItem
    property string buttonType
    property bool btnstates: false
    implicitWidth: img.width
    implicitHeight: img.height
    Image {
        id: img
        source: rootId.icon_default
        width: rootId.widthItem
        height: rootId.heightItem
    }
    onClicked: {
        btnstates = !btnstates
        if(btnstates == true){
            img.source = icon_pressed
        }
        if(btnstates == false){
            img.source = icon_released
        }
        if(buttonType == "shuffle"){
             player.shuffleButtonState(btnstates)
        }
        if(buttonType == "replay"){
             player.replayButtonState(btnstates)
        }
    }
}
