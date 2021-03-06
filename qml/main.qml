import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.2
import MeuiKit 1.0 as Meui
import org.cyber.DiskUsage 1.0

Meui.Window {
    visible: true
    id: rootWindow
    title: qsTr("Disk Usage")
    width: 500
    height: 400
    minimumWidth: 500
    minimumHeight: 400

    Backend {
        id: backend
    }

    headerBar: Rectangle {
        color: "transparent"
        anchors.fill: parent
        anchors.rightMargin: -140

        Label {
            text: rootWindow.title
            // TODO: Make this a separate variable in Meui.Theme,
            //       maybe Meui.Theme.titleBarTextColor?
            color: Meui.Theme.darkMode ? "#cacbce" : "#383838"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
        }
    }


    DelegateModel {
        id: driveModel
        model: backend.getDrives

        delegate: DiskItem {
            required property variant modelData
            anchors.left: parent.left
            anchors.right: parent.right

            key: modelData['name']
            value: modelData['usage']
            image: "qrc:/images/drive-partition.svg"
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        ListView {
            id: listView
            anchors.fill: parent
            model: driveModel
            clip: true

            ScrollBar.vertical: ScrollBar {}
        }
    }
}
