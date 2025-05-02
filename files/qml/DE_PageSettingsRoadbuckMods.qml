import QtQuick 1.1
import "utils.js" as Utils
import com.victron.velib 1.0

MbPage {
	id: root
	title: qsTr("Roadbuck Mods")
		property string bindPrefixRbMods: "com.victronenergy.settings/Settings/RoadbuckMods"
		property string bindPrefix: "com.victronenergy.settings/Settings/Gui"
		VBusItem { id: showStarter; bind: Utils.path(bindPrefixRbMods, "/StarterBattery/ShowStarterBattery")}
		VBusItem { id: showTruma; bind: Utils.path(bindPrefixRbMods, "/Truma/ShowTrumaOverview")}
		VBusItem { id: showMaxxFan; bind: Utils.path(bindPrefixRbMods, "/MaxxFan/ShowMaxxFanOverview")}
		VBusItem { id: showShelly; bind: Utils.path(bindPrefixRbMods, "/Shelly/ShowShellyOverview")}
		VBusItem { id: showWeather; bind: Utils.path(bindPrefixRbMods, "/Weather/ShowWeatherOverview")}
		VBusItem { id: showTeltonika; bind: Utils.path(bindPrefixRbMods, "/Teltonika/ShowTeltonikaOverview")}
		VBusItem { id: showEcoFlow; bind: Utils.path(bindPrefixRbMods, "/EcoFlow/ShowEcoFlowOverview")}
		VBusItem { id: showRelayBox; bind: Utils.path(bindPrefixRbMods, "/Relays/ShowRelays")}
	model: VisibleItemModel
	{

			MbSubMenu
			{
				description: qsTr("Starterbatterie")
				subpage: Component { PageSettingsRoadbuckStarterBattery {} }
				show: showStarter.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("Truma")
				subpage: Component { PageSettingsRoadbuckTruma {} }
				show: showTruma.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("MaxxFan")
				subpage: Component { PageSettingsRoadbuckMaxxFan {} }
				show: showMaxxFan.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("Teltonika")
				subpage: Component { PageSettingsRoadbuckTeltonika {} }
				show: showTeltonika.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("Shelly")
				subpage: Component { PageSettingsRoadbuckShelly {} }
				show: showShelly.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("EcoFlow")
				subpage: Component { PageSettingsRoadbuckEcoFlow {} }
				show: showEcoFlow.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("RelaisBox")
				subpage: Component { PageSettingsRoadbuckRelayBox {} }
				show: showRelays.value >= 0
			}

			MbSubMenu
			{
				description: qsTr("Wetter")
				subpage: Component { PageSettingsRoadbuckWeather {} }
				show: showWeather.value >= 0
			}

  } // VisibleItemModel

} //MbPage
