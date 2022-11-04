import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    id: main
    visible: true
    width: 480
    height: 320
    title: 'PMP Glossary Flash Cards'
    
    background: Flipable {
                    id: flipable
                    width: 240
                    height: 240
                    anchors.centerIn: parent
                    
                    property bool flipped: false

                    front: Item {
                            width: 240
                            height: 240

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
                                text: "Front Hello";
                                anchors.centerIn: fcard
                            }
                        }
                    back: Item {
                            width: 240
                            height: 240

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
                                text: "Back Hello";
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
                        NumberAnimation { target: rotation; property: "angle"; duration: 400 }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: flipable.flipped = !flipable.flipped
                    }
                }
}
