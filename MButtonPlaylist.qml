import QtQuick 2.0

MouseArea {
    id: root
    property string icon_on: ""
    property string icon_off: ""
    property int status: 0 //0-Off 1-On
    signal drawerOpen()
    signal drawerClose()
    implicitWidth: img.width
    implicitHeight: img.height
    Image {
        id: img
        anchors.centerIn: parent
        height:30
        width: 30
        source: root.status === 0 ? icon_off : icon_on
    }
    onClicked: {
        status = !status
        if(status==true){
           drawerOpen()
        }
        if(status==false){
           drawerClose()
        }
    }
}
