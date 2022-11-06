import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

ApplicationWindow {
    id: main
    visible: true
    width: 800
    height: 640
    title: 'PMP Glossary Flash Cards'
    
    background: ColumnLayout {
        spacing: 80
        anchors.fill: parent
        Flipable {
            id: flipable
            width: 600
            height: 380
            Layout.topMargin: 20
            Layout.alignment: Qt.AlignHCenter
            property bool flipped: false

            front: Item {
                    width: 600
                    height: 380
                    anchors.centerIn:flipable

                    Rectangle {
                        id: fcard
                        width:parent.width
                        height:parent.height
                        color: "white"
                        radius: 22.5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    DropShadow {
                        anchors.fill: fcard
                        horizontalOffset: 3
                        verticalOffset: 3
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: fcard
                    }

                    Text {
                        id: frontContent
                        text: "Front Content";
                        font.family:  "Lato"
                        font.pointSize: 13;
                        lineHeight: 1.2 
                        width: parent.width
                        padding: 30
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignJustify
                        anchors.verticalCenter: fcard.verticalCenter
                        anchors.horizontalCenter: fcard.horizontalCenter
                    }
                }
            back: Item {
                    width: 600
                    height: 380
                    anchors.centerIn:flipable
                    
                    Rectangle {
                        id: bcard
                        width:parent.width
                        height:parent.height
                        color: "white"
                        radius: 22.5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    DropShadow {
                        anchors.fill: bcard
                        horizontalOffset: 3
                        verticalOffset: 3
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: bcard
                    }

                    Text {
                        id: backContent
                        text: "Back Content";
                        font.family:  "Lato"
                        font.pointSize: 24;
                        color: Material.color(Material.LightBlue)
                        width: parent.width
                        wrapMode: Text.WordWrap
                        padding: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: bcard.verticalCenter
                        anchors.horizontalCenter: bcard.horizontalCenter
                    }
                }

            transform: Rotation {
                id: rotation
                origin.x: flipable.width/2
                origin.y: flipable.height/2
                axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states: State {
                name: "back"
                PropertyChanges { target: rotation; angle: 180 }
                when: flipable.flipped
            }

            transitions: Transition {
                NumberAnimation { target: rotation; property: "angle"; duration: 300 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: flipable.flipped = !flipable.flipped
            }
        }
        RowLayout {
            spacing: 80
            Layout.alignment:Qt.AlignHCenter | Qt.AlignBaseline
            Button {
                text: "Prev"
                font.family:  "Lato"
                onClicked: termGenerator.decrementIndex()
            }
            
            Label {
                id: indexLabel 
                font.family:  "Lato"
            }
            
            Button {
                text: "Next"
                font.family:  "Lato"
                onClicked: termGenerator.incrementIndex()
            }
        }
    }

    Connections {
        target: termGenerator
        function onUpdateCard(front, back, index) {
            frontContent.text = front
            flipable.flipped = false
            backContent.text = back
            indexLabel.text = index
        }
    }
}
