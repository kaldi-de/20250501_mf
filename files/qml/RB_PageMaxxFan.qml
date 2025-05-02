import QtQuick 1.1


VBusItem {
    id: showOverviewMaxxFan
    bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/ShowMaxxFanOverview"
    onValueChanged: extraOverview ("OverviewMaxxFan.qml", value === 1)
}
