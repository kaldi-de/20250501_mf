import QtQuick 1.1
import "utils.js" as Utils
import com.victron.velib 1.0

MbPage {
	id: root
	title: qsTr("Konfiguration MaxxFan")
    property string bindPrefixRoadbuckMods: "com.victronenergy.settings/Settings/RoadbuckMods"
		VBusItem { id: use_internal_temp_sensor; bind: Utils.path(bindPrefixRbMods, "/MaxxFan/UseInternalTempSensor")}

	model: VisualItemModel
    {
	MbSwitch {
			id: maxxFanOnMainPage
			bind: Utils.path(bindPrefixRbMods, "/MaxxFan/ShowMaxxFanOverview")
			name: qsTr ("MaxxFan Seite anzeigen")
			writeAccessLevel: User.AccessUser
			}

  MbItemOptions
  {
      id: connection_type
      description: qsTr ("Verbindungstyp")
      bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/ConnectionType")
      possibleValues:
      [
          MbOption { description: qsTr("USB/Seriell"); value: 1 },
          MbOption { description: qsTr("WiFi"); value: 2 },
          MbOption { description: qsTr("deaktiviert"); value: 0 }
      ]
      writeAccessLevel: User.AccessUser
  }

	MbItemOptions
	  {
	      id: internalTempSensor
				//description: qsTr ("Temperatursensor " + use_internal_temp_sensor.value)
	      description: qsTr ("Temperatursensor")
	      bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/UseInternalTempSensor")
	      possibleValues:
	      [
	          MbOption { description: qsTr("RB-MaxxFan-Modul"); value: 1 },
	          MbOption { description: qsTr("anderer"); value: 0 }
	      ]
	      writeAccessLevel: User.AccessUser
	  }

		MbEditBox {
            id: useTempInsideSensor
						description: qsTr("Sensor Temperatur innen")
            item.bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/TempInsideSensor")
            maximumLength: 32
            enableSpaceBar: false
						writeAccessLevel: User.AccessUser
        }


	MbSpinBox {
			id: temperature_offset
						description: qsTr ("Offset Temperatur")
			item			{
				bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/TemperatureOffset")
				unit: "°"
				decimals: 1
				step: 0.1
				min: -10
				max: 10
			}
						writeAccessLevel: User.AccessUser
				}


 MbSpinBox {
			id: humidity_offset
						description: qsTr ("Offset Luftfeuchtigkeit")
			item
			{
				bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/HumidityOffset")
				unit: "%"
				decimals: 0
				step: 1
				min: -10
				max: 10
			}
						writeAccessLevel: User.AccessUser
				}
/*
	MbEditBox {
            id: tempInsideSensor
            description: qsTr("Sensor Temperatur innen")
            item.bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/TempInsideSensor")
            maximumLength: 32
            enableSpaceBar: false
						writeAccessLevel: User.AccessUser
        }
*/
MbEditBox {
            id: tempOutsideSensor
            description: qsTr("Sensor Temperatur außen")
            item.bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/TempOutsideSensor")
            maximumLength: 32
            enableSpaceBar: false
						writeAccessLevel: User.AccessUser
        }

MbEditBox {
            id: humiditySensor
            description: qsTr("Sensor Luftfeuchtigkeit")
            item.bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/HumiditySensor")
            maximumLength: 32
            enableSpaceBar: false
						writeAccessLevel: User.AccessUser
        }

MbSwitch {
			id: image_animation
			bind: Utils.path(bindPrefixRbMods, "/MaxxFan/ImageAnimation")
			name: qsTr ("Animierte Grafiken")
			writeAccessLevel: User.AccessUser
			}



/*
	MbItemOptions
		{
				id: dynamic_fanspeed
				description: qsTr ("Dynamische Lüftergeschwindigkeit")
				bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/DynamicFanSpeed")
				possibleValues:
				[
						MbOption { description: qsTr("ja"); value: 1 },
						MbOption { description: qsTr("nein"); value: 0 }
				]
				writeAccessLevel: User.AccessUser
		}
*/
/*
		MbSpinBox {
				id: default_fanspeed
							description: qsTr ("Standard Lüftergeschwindigkeit")
				item
				{
					bind: Utils.path (bindPrefixRoadbuckMods, "/MaxxFan/DefaultFanSpeed")
					decimals: 0
					step: 1
					min: 0
					max: 10
				}
							writeAccessLevel: User.AccessUser
					}
*/
}
}
