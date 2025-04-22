import QtQuick 2.0
import QtQuick.Controls 2.5

Drawer{
    id:drawerId
    y: headerItem.height
    width: playlistId.width
    interactive: false
    modal: false
    signal changedPlaybutton()
    background: Rectangle {
        id: playList_bg
        anchors.fill: parent
        gradient:Gradient{
            GradientStop{position: 0.0;color:"#242428"}
            GradientStop{position: 1.0;color:"#121216"}
        }
    }
    function drawerControlopen(){
        drawerId.open()
    }
    function drawerControlclose(){
        drawerId.close()
    }
    ListView{
        id:listViewId
        anchors.fill:parent
        model: PlaylistModel
        clip: true
        currentIndex: 0
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: drawerId.width
                height: 120
                source: "qrc:/Image/playlist.png"
                opacity: 0.5
            }
            Text {
                text: nameSong
                anchors.fill: parent
                anchors.leftMargin:40
                font.pointSize: 16
                verticalAlignment: Text.AlignVCenter
                color: "white"
                z:2
            }
            onClicked: {
               listViewId.currentIndex = index
                player.jumpTomedia(index)
                player.stop()
            }

            onPressed: {
                playlistItem.source = "qrc:/Image/hold.png"
            }
            onReleased: {
                playlistItem.source = "qrc:/Image/playlist.png"
            }
        }
        highlight:PlayedMusic{}

        ScrollBar.vertical: ScrollBar {
        }
        onCurrentIndexChanged: {
            player.onoffState(false);
            player.stop()

        }
}
    Connections{
        target: player
        onCurrentIndexChanged: {
            listViewId.currentIndex = index;
        }
}
}
