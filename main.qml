import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
//import myType.PlaylistModel 1.0
//import QtQuick.Layouts 1.3
    ApplicationWindow {
        visible: true
        width: 1920
        height: 1080
        //visibility: "FullScreen"
        title: qsTr("Media Player")
        //Backgroud of Application
        Image {
            id: backgroud
            anchors.fill: parent
            source: "qrc:/Image/background.png"
        }
        //Header
        AppHeader{
            id: headerItem
            width: parent.width
            height: 80
            onPlaylistOpen: {
               playlistId.drawerControlopen()
               mediaInfoControl.moveAway()
            }
            onPlaylistClose: {
               playlistId.drawerControlclose()
                mediaInfoControl.returnTo()
            }
            }


        //Playlist
         PlaylistView{
            id: playlistId
            y: headerItem.height
            width: 400
            height: parent.height - headerItem.height
            signal listViewClicked()
            onChangedPlaybutton:{

            }
        }


        //Media Info
        MediaInfoControl{
            id: mediaInfoControl
            anchors.top: headerItem.bottom
            anchors.right: playlistId.right
            anchors.left: parent.left
    //        anchors.leftMargin: ...
            anchors.bottom: parent.bottom
            signal moveAway()
            signal returnTo()
            signal artViewClicked()
            onMoveAway: {
                isRunning = true
            }
            onReturnTo: {
                isReturning = true
            }

        }
    }
