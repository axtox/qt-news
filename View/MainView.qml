import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import Main 1.0
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window

    width: 500
    height: 500
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    visible: true
    title: qsTr("Новости LENTA.RU")


    Material.theme: Material.System
    Material.accent: Material.Purple
    color: "grey"

    Component.onCompleted: {

        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2


        var task = main.getnews()
        Net.await(task, function(result) {
            listView.model = Net.toListModel(result)
        })
    }

   /*StackView {
        id: stack
        initialItem: mainView
        anchors.fill: parent
    }

    Component {
        id: mainView

        Row {
            spacing: 10

            Button {
                text: "Push"
                onClicked: stack.push(mainView)
            }
            Button {
                text: "Pop"
                enabled: stack.depth > 1
                onClicked: stack.pop()

            }
            Text {
                text: stack.depth
            }
        }
    }*/

    ListView {
        id: listView
        anchors.fill: parent
        anchors.margins: 10
        //anchors.paddings: 10
        delegate: newsTemplate
        highlight: Rectangle { color: "lightsteelblue"; }
        focus: true

        Component {
            id: newsTemplate
            Pane {
                //spacing: 10
                //Layout.fillWidth: true
                width: listView.width
                //clip: true
                //Material.background: Material.Deafult
                //Material.elevation: 6
                //Material.theme: Material.Dark
                ColumnLayout {
                    anchors.fill: parent


                    Image {
                        id: newsImage
                        //anchors.fill: parent
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectCrop
                        source: modelData.image       
                        //sourceSize.width: listView.width
                    }
                    Label {
                        Layout.fillWidth: true
                        text: modelData.title
                        wrapMode: Text.WordWrap
                    }
                    Text {
                        Layout.fillWidth: true
                        text: modelData.description
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignJustify
                    }
                    ToolSeparator {
                        Layout.fillWidth: true
                        orientation: Qt.Horizontal
                    }
                }
            }
        }
    }

    

    MainViewModel {
        id: main
    }
}
