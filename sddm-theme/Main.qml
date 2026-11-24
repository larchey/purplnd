import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 640
    height: 480
    color: "#0a0a12"

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        function onLoginSucceeded() { }
        function onLoginFailed() {
            password.text = ""
            errorMsg.text = "Wrong password"
            errorMsg.visible = true
        }
    }

    // Clock
    Text {
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.12
        font.family: "JetBrainsMono Nerd Font"
        font.pointSize: 64
        font.bold: true
        color: "#c8a0e8"
        text: Qt.formatTime(new Date(), "hh:mm")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm")
        }
    }

    // Date
    Text {
        id: dateText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: clock.bottom
        anchors.topMargin: 10
        font.family: "JetBrainsMono Nerd Font"
        font.pointSize: 16
        color: "#555566"
        text: Qt.formatDate(new Date(), "dddd, MMMM d")
    }

    // Login container
    Column {
        anchors.centerIn: parent
        spacing: 15
        width: 280

        // User greeting
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 14
            color: "#8a64b4"
            text: "Welcome"
        }

        // Username
        Rectangle {
            width: parent.width
            height: 45
            color: "#15151f"
            radius: 8
            border.color: "#333344"
            border.width: 1

            TextInput {
                id: username
                anchors.fill: parent
                anchors.margins: 10
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 12
                color: "#e0e0e8"
                text: userModel.lastUser
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                clip: true
                onAccepted: password.forceActiveFocus()
            }
        }

        // Password
        Rectangle {
            width: parent.width
            height: 45
            color: "#15151f"
            radius: 8
            border.color: password.activeFocus ? "#8a64b4" : "#333344"
            border.width: password.activeFocus ? 2 : 1

            TextInput {
                id: password
                anchors.fill: parent
                anchors.margins: 10
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 12
                color: "#e0e0e8"
                echoMode: TextInput.Password
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                clip: true
                focus: true
                onAccepted: sddm.login(username.text, password.text, sessionModel.lastIndex)
            }
        }

        // Error message
        Text {
            id: errorMsg
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 11
            color: "#c06080"
            text: ""
            visible: false
        }

        // Login button
        Rectangle {
            width: parent.width
            height: 45
            color: loginMouse.containsMouse ? "#9d7cd8" : "#8a64b4"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: "Login"
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 12
                color: "#0a0a12"
            }

            MouseArea {
                id: loginMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: sddm.login(username.text, password.text, sessionModel.lastIndex)
            }
        }

        // Session
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 10
            color: "#555566"
            text: sessionModel.data(sessionModel.index(sessionModel.lastIndex, 0), Qt.DisplayRole)
        }
    }

    // Power buttons
    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        spacing: 15

        Text {
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 11
            color: shutdownMouse.containsMouse ? "#c8a0e8" : "#555566"
            text: "Shutdown"

            MouseArea {
                id: shutdownMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }

        Text {
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 11
            color: rebootMouse.containsMouse ? "#c8a0e8" : "#555566"
            text: "Reboot"

            MouseArea {
                id: rebootMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }
    }
}
