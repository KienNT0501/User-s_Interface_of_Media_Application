import QtQuick 2.0
Item {
    property bool imgSelected : false
    signal playlistOpen()
    signal playlistClose()
     Image{

          width: parent.width
          height: parent.height
          source: "qrc:/Image/title.png"

          MButtonPlaylist{
              id:mbuttonplaylistId
              icon_on: "qrc:/Image/back.png"
              icon_off: "qrc:/Image/drawer.png"
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              height:50
              width:50
              onDrawerOpen: {
                  playlistOpen()

              }
              onDrawerClose: {
                  playlistClose()
              }
          }
          Text{
              id:playlistTextId
              text:qsTr("STR_MAIN_LABEL") + Translator.updateText
              font.pointSize: 18
              //font.bold: true
              color:"white"
              x:50
              anchors.verticalCenter: parent.verticalCenter
          }
          Text{
              id:mediaPlayertextId
              text:qsTr("STR_MAIN_TITLE")+Translator.updateText
              font.pointSize: 20
              //font.bold: true
              color:"white"
              anchors.centerIn: parent
              onTextChanged: {
                  textChangeAni.targets = [mediaPlayertextId,playlistTextId]
                  textChangeAni.restart()
              }
          }
          NumberAnimation {
              id: textChangeAni
              property: "opacity"
              from: 0
              to: 1
              duration: 400
              easing.type: Easing.OutInQuad
          }
          Image {
              id: vn_img
              source: "qrc:/Image/vn.png"

              width:30
              height: 30
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: parent.right
              anchors.rightMargin: 20
              Rectangle{
                  width: 30
                  height: 24
                  anchors.centerIn: parent
                  border.color: "gray"
                  border.width: 3
                  color: "transparent"
                  visible: imgSelected? true:false
              }
              MouseArea{
                  anchors.fill:parent
                  onClicked: {
                      imgSelected = true
                      Translator.setLanguage(1)
                  }
              }
          }
          Image {
              id: usa_img
              source: "qrc:/Image/us.png"
              width:30
              height: 30
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: vn_img.left
              anchors.rightMargin: 10
              Rectangle{
                  width: 30
                  height: 24
                  anchors.centerIn: parent
                  border.color: "gray"
                  border.width: 3
                  color: "transparent"
                  visible: imgSelected? false:true
              }
              MouseArea{
                  anchors.fill:parent
                  onClicked: {
                      imgSelected = false
                      Translator.setLanguage(0)
                  }
              }
          }
     }
}
