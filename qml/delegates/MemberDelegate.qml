import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material

import "qrc:/qml"

XSwipeDelegate {
    id: memberDelegate
    width: memberListView.width

    text: name
    secondaryText: job

    swipe.right: deleteComponent
    swipe.onCompleted: {
        viewModel.deleteMember(guid, index)
    }
    Component {
        id: deleteComponent

        Rectangle {
            id: editContainer
            width: parent.width
            height: parent.height
            color: Material.color(Material.Red)
            visible: swipe.position !== 0

            IconLabel {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                icon.source: "qrc:/img/icons/delete.svg"
                icon.width: 32
                icon.height: 32
                icon.color: "#FFFFFF"
            }
        }
    }

    ListView.onRemove: SequentialAnimation {
        PropertyAction {
            target: memberDelegate
            property: "ListView.delayRemove"
            value: true
        }
        NumberAnimation {
            target: memberDelegate
            property: "height"
            to: 0
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: memberDelegate
            property: "ListView.delayRemove"
            value: false
        }
    }

    onClicked: {
        homeNavController.gotoView(homeNavController.memberDetailsViewIndex, guid)
    }
}
