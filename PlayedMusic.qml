import QtQuick 2.0

Rectangle{
    id:rectHighlightId
    opacity: 0.5
    //anchors.horizontalCenter: backgroundId1.horizontalCenter
    width: playlistId.width
    implicitHeight:120
    color:"#0F0F10"
    Image{
        id:soundIcon
        x:10
        width:20
        height:20
        source:"qrc:/Image/playing.png"
        anchors.verticalCenter: parent.verticalCenter
    }
}

