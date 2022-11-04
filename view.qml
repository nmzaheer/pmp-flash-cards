import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

ApplicationWindow {
    id: main
    visible: true
    width: 640
    height: 480
    title: 'PMP Glossary Flash Cards'
    
    background: ColumnLayout {
        spacing: 0
        Flipable {
            id: flipable
            width: 400
            height: 400
            Layout.topMargin: 20
            Layout.alignment:Qt.AlignHCenter | Qt.AlignVCenter
            property bool flipped: false

            front: Item {
                    width: 400
                    height: 400

                    Image {
                        id: fcard
                        source: "card.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        smooth: true
                        visible: false
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
                        width: parent.width
                        padding: 30
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignJustify
                        anchors.verticalCenter: fcard.verticalCenter
                        anchors.horizontalCenter: fcard.horizontalCenter
                    }
                }
            back: Item {
                    width: 400
                    height: 400

                    Image {
                        id: bcard
                        source: "card.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        smooth: true
                        visible: false
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
                        font.pointSize: 24;
                        color: Material.Purple
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
        Row {
            spacing: 80
            Layout.alignment:Qt.AlignHCenter
            Button {
                text: "Prev"
                onClicked: termGenerator.decrementIndex()
            }
            Button {
                text: "Next"
                onClicked: termGenerator.incrementIndex()
            }
        }
        Item { Layout.fillHeight: true } 
    }

    Connections {
        target: termGenerator
        function onUpdateCard(front, back) {
            frontContent.text = front
            flipable.flipped = false
            backContent.text = back
        }
    }
}
