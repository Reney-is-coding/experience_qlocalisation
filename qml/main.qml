import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtLocation 5.6
import QtPositioning 5.6

Window {
    width: Qt.platform.os == "android" ? Screen.width : 512
    height: Qt.platform.os == "android" ? Screen.height : 512
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(43.6,  3.8833)
        zoomLevel: 14
    }

    Dialog {
        id: dialog
        title: "Choix des coordonnées"
        modal: true
        visible: true
        width : parent.width * 0.9
        height : parent.height * 0.9
        x : parent.width * 0.05
        y : parent.width * 0.05
        standardButtons: Dialog.Ok | Dialog.Cancel

        Row {
          y: parent.height / 3
          width : parent.width

          Text {
            width : parent.width / 2
            text: "longitude :"
          }

          SpinBox {
              id: longSpinbox
              from: 0
              value: 4360
              to: 100 * 100
              stepSize: 100
              anchors.centerIn: parent

              property int decimals: 2
              property real realValue: value / 100

              validator: DoubleValidator {
                  bottom: Math.min(spinbox.from, spinbox.to)
                  top:  Math.max(spinbox.from, spinbox.to)
              }

              textFromValue: function(value, locale) {
                  return Number(value / 100).toLocaleString(locale, 'f', spinbox.decimals)
              }

              valueFromText: function(text, locale) {
                  return Number.fromLocaleString(locale, text) * 100
              }
          }
        }

        Row {
          y: parent.height * 2 /3
          width : parent.width
          Text {
            width : parent.width / 2
            text: "latitude :"
          }

          SpinBox {
              id: spinbox
              from: 0
              value: 3680
              to: 100 * 100
              stepSize: 100
              anchors.centerIn: parent

              property int decimals: 2
              property real realValue: value / 100

              validator: DoubleValidator {
                  bottom: Math.min(spinbox.from, spinbox.to)
                  top:  Math.max(spinbox.from, spinbox.to)
              }

              textFromValue: function(value, locale) {
                  return Number(value / 100).toLocaleString(locale, 'f', spinbox.decimals)
              }

              valueFromText: function(text, locale) {
                  return Number.fromLocaleString(locale, text) * 100
              }
          }
        }

        onAccepted: map.center =  QtPositioning.coordinate(longSpinbox.value, spinbox.valuea)
        onRejected: console.log("Cancel clicked")
    }

}
