import QtQuick 1.1
import "utils.js" as Utils
import com.victron.velib 1.0

MbPage {
	id: root
	title: qsTr("Konfiguraton RelaisBox")
    property string bindPrefixRoadbuckMods: "com.victronenergy.settings/Settings/RoadbuckMods"

	model: VisualItemModel
    {
			MbSwitch {
								id: starterBatteryOnMainPage
								bind: Utils.path(bindPrefixRbMods, "/Relays/ShowRelays")
								name: qsTr ("RelaisBox auf Startseite anzeigen")
								writeAccessLevel: User.AccessUser
						}

			MbSpinBox {
					description: qsTr ("X-Position")
		item
		{
			bind: Utils.path (bindPrefixRoadbuckMods, "/Relays/Relay_X")
			decimals: 0
			step: 1
			min: 10
			max: 322
		}
					writeAccessLevel: User.AccessUser
			}

			MbSpinBox {
					description: qsTr ("Y-Position")
		item
		{
			bind: Utils.path (bindPrefixRoadbuckMods, "/Relays/Relay_Y")
			decimals: 0
			step: 1
			min: 10
			max: 322
		}
					writeAccessLevel: User.AccessUser
			}


    }
}
