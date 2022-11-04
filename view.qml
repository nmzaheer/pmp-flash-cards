import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    id: main
    visible: true
    width: 640
    height: 480
    title: 'PMP Glossary Flash Cards'
    
    background: Flipable {
                    id: flipable
                    width: 400
                    height: 400
                    anchors.centerIn: parent
                    
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
                                wrapMode: Text.WordWrap
                                anchors.centerIn: fcard
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
                                width: parent.width
                                wrapMode: Text.WordWrap
                                anchors.centerIn: bcard
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
    footer: Row {
                Button {
                    text: "Prev"
                    onClicked: termGenerator.decrementIndex()
                }
                Button {
                    text: "Next"
                    onClicked: termGenerator.incrementIndex()
                }
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
