import QtQuick 1.1
import com.victron.velib 1.0
import "utils.js" as Utils

OverviewPage {
	id: root
  title: qsTr("MaxxFan")
	clip: true

	/////// MB Temperaturen über Ruuvi Sensoren
	//innen bei iNet Sensor
	//VBusItem { id: ruuviTempInside; bind: Utils.path("com.victronenergy.temperature.ruuvi_cbad87dae0dc", "/Temperature") }  // manuell anpassen: ruuvi_??????? (dbus-spy)
	//außen
	VBusItem { id: temp_sensor_outside; bind: Utils.path("com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/TempOutsideSensor") }  // manuell anpassen: ruuvi_??????? (dbus-spy)
	VBusItem { id: sensorTempOutside; bind: Utils.path("com.victronenergy.temperature."+ temp_sensor_outside.value + "", "/Temperature") }  // manuell anpassen: ruuvi_??????? (dbus-spy)
	//innen
	VBusItem { id: temp_sensor_inside; bind: Utils.path("com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/TempInsideSensor") }  // manuell anpassen: ruuvi_??????? (dbus-spy)
	VBusItem { id: sensorTempInside; bind: Utils.path("com.victronenergy.temperature."+ temp_sensor_inside.value + "", "/Temperature") }  // manuell anpassen: ruuvi_??????? (dbus-spy)
	//Luftfeuchtigkeit
	VBusItem { id: ruuviHumidity; bind: Utils.path("com.victronenergy.temperature."+ temp_sensor_inside.value + "", "/Humidity")}


	//for debugging
	  property int debug_mode: 0
		property int debug_counter: 0
		property int show_error_details: 0

		property int service_mode: 0
		property int service_counter: 0
	// NEU: internal sensor from RB SmartMQTT
	property VBusItem maxxfan_humidity: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/Humidity" }
	property VBusItem maxxfan_humidity_offset: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/HumidityOffset" }

	property VBusItem maxxfan_temperature: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/Temperature" }
	property VBusItem maxxfan_temperature_offset: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/TemperatureOffset" }


	property VBusItem maxxfan_ir_signal: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/IrSignal" }

	//Status
	property VBusItem maxxfan_status_open: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/StatusOpen" }  // 0 or 1
	property VBusItem maxxfan_status_temperature: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/StatusTemperature" }  // 0 or 1
	property VBusItem maxxfan_status_fanspeed: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/StatusFanspeed" }  // 0 or 1
	property VBusItem maxxfan_status_airflow: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/StatusAirflow" }  // 0 or 1
	property VBusItem maxxfan_status_automode: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/StatusAutoMode" }  // 0 or 1
	property VBusItem maxxfan_status_testmode: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/StatusTestmode" }

	property VBusItem maxxfan_set_fanspeed: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/SetFanspeed" }  // 0 or 1
	property VBusItem maxxfan_set_temperature: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/SetTemperature" }  // 0 or 1

	property VBusItem image_animation: VBusItem { bind: "com.victronenergy.settings/Settings/RoadbuckMods/MaxxFan/ImageAnimation" }  // 0 or 1

	// Temperaturauswahl
	property int fanTemperature: maxxfan_status_temperature.value
	property int setTemperature: maxxfan_status_temperature.value

	//AutoModus
	property int autoMode: maxxfan_status_automode.value
	//property int setAutoMode: 0

	// Air IN-Out
	property int airModeOut: maxxfan_status_airflow.value
	//property int airModeIn: 0

	// MaxxFan offen / geschlossen
	property int maxxfanOpen: maxxfan_status_open.value

	// IR-Signal
	property string irSignal: ""

	//MB modification for dark background start
	        Rectangle
	            {
	                anchors
	                {
	                    fill: parent
	                }
	                //color: root.backgroundColor
	                        color: "#0F3051"
													//color: "#000000"

	            }
	 //MB modification for dark background end


// ------------------------------------------------------------------------------------------ SPALTE OBEN ---------------

 //------------------------ MaxxFan LOGO
	 MbIcon {
				 iconId: "rb_maxxfan_logo_neu"
				 rotation: 0
				 x: 10
				 y: 20
				 //opacity: 0.4
				 //visible: relay1State.text == 0 && relay1Show.text == 1
				 visible: debug_mode == 0
				 width: 140 // 120 // 150 // 180 // 150
				 height: 33 // 21 // 27 // 42  // 28
				 }

// ----------------------------------------------------------------------------- Uhr


		 Timer {
		 				id: wallClock
		 				running: true
		 				repeat: true
		 				interval: 1000
		 				triggeredOnStart: true
		 				onTriggered: time = Qt.formatDateTime(new Date(), ('hh:mm'))
		 				property string time
		 		}

		 		TileText
		 					{
		 						text: wallClock.time
								visible: debug_mode == 0 && service_mode == 0
		 						x: 160
		 						y: 10
		 						width:160
		 						height:40
		 						font.pixelSize: 40
		 						font.bold: true
		 						horizontalAlignment: Text.Center

		 						anchors{
		 									top: parent.top; topMargin: 10
		 								}

		 					}

//------------------------------------------------------------------------- DEBUG_MODE_BUTTON
MouseArea {
		id: debugModeCounter
    x: 10
    y: 10
    width: 80
    height: 40
    visible: debug_mode == 0
    onClicked: {
				if (debug_counter < 4){
					debug_counter = debug_counter + 1;
					debug_mode = 0;
					}
				else {
					debug_counter = 0;
					debug_mode = 1;
				}
		}
}

MouseArea {
		id: debutModeButton
    x: 10
    y: 10
    width: 80
    height: 40
    visible: debug_mode == 1
    onClicked: debug_mode = 0

}

//------------------------------------------------------------------------- SERVICE_MODE_BUTTON
MouseArea {

    x: 200
    y: 10
		width: 80
    height: 40
    visible: service_mode == 0
    onClicked: {
				if (service_counter < 4){
					service_counter = service_counter + 1;
					service_mode = 0;
					}
				else {
					service_counter = 0;
					service_mode = 1;
				}
		}

Button{
					id: button_Reboot
					x: 160
					y: 15
					width: 75
					height: 30
					radius: 5
					baseColor: "#4C6981"
					pressedColor: "#3399ff"
					visible: debug_mode == 0 && service_mode == 1

					onClicked: {
							maxxfan_ir_signal.setValue("reboot")
						}


					TileText {
						text: "Reboot"
						font.pixelSize: 12
						font.bold: true
						color: "#ffffff"

						anchors{
							horizontalCenter: button_Reboot.horizontalCenter
							verticalCenter: button_Reboot.verticalCenter
							}
					}

				}

Button{
					id: button_APMode
					x: 160+75+10
					y: 15
					width: 75
					height: 30
					radius: 5
					baseColor: "#4C6981"
					pressedColor: "#3399ff"
					visible: debug_mode == 0 && service_mode == 1

					onClicked: {
							maxxfan_ir_signal.setValue("start_ap")
						}



					TileText {
						text: "AP-Mode"
						font.pixelSize: 12
						font.bold: true
						color: "#ffffff"
						anchors{
							horizontalCenter: button_APMode.horizontalCenter
							verticalCenter: button_APMode.verticalCenter
							}
					}

				}


Button{
					id: button_TestMode
					x: 330
					y: 15
					width: 75
					height: 30
					radius: 5
					baseColor: maxxfan_status_testmode.value == 0 ? "#4C6981" : "#ff0000"
					pressedColor: "#3399ff"
					visible: debug_mode == 0 && service_mode == 1

					onClicked: {
							maxxfan_status_testmode.setValue(1)
						}

					TileText {
						text: "Test"
						font.pixelSize: 12
						font.bold: true
						color: "#ffffff"
						anchors{
							horizontalCenter: button_TestMode.horizontalCenter
							verticalCenter: button_TestMode.verticalCenter
							}
					}

				}

Button{
					id: button_ExitTestMode
					x: 415
					y: 15
					width: 30
					height: 30
					radius: 5
					baseColor: maxxfan_status_testmode.value == 0 ? "#4C6981" : "#ff0000"
					pressedColor: "#3399ff"
					visible: debug_mode == 0 && service_mode == 1

					onClicked: {
							service_mode = 0
						}

					TileText {
						text: "X"
						font.pixelSize: 12
						font.bold: true
						color: "#ffffff"
						anchors{
							horizontalCenter: button_ExitTestMode.horizontalCenter
							verticalCenter: button_ExitTestMode.verticalCenter
							}
					}

				}

//------------------------------------------------------------------------------------------- DEBUGGER

 TileText{
	text: "irSignal: " + maxxfan_ir_signal.value + "\n" +
				"setFanSpeed: " + maxxfan_set_fanspeed.value + "\n" +
				"fanSpeed: " + maxxfan_status_fanspeed.value + "\n" +
				"StatusFanspeed: " + maxxfan_status_fanspeed.value
	color: "#66ff33"
	font.pixelSize: 10
	font.bold: false
	visible: debug_mode == 1

	x:80
	y:5

	horizontalAlignment: Text.AlignLeft

}

TileText{
 text: "Airflow: " + maxxfan_status_airflow.value + "\n" +
			 "Open?: " + maxxfan_status_open.value + "\n" +
			 "AutoMode: " + maxxfan_status_automode.value

 color: "#66ff33"
 font.pixelSize: 10
 font.bold: false
 visible: debug_mode == 1

 x:200
 y:5

 horizontalAlignment: Text.AlignLeft

}


TileText{
 text: "StatusTemperature: " + maxxfan_status_temperature.value + "\n" +
			 "SetTemperature: " + setTemperature + "\n" +
			 "FanTemperature: " + fanTemperature + "\n" +
			 "Sensor Temp:" + (maxxfan_temperature.value + maxxfan_temperature_offset.value).toFixed(1) + "|" + sensorTempOutside.value.toFixed(1)

 color: "#66ff33"
 font.pixelSize: 10
 font.bold: false
 visible: debug_mode == 1

 x:320
 y:5

 horizontalAlignment: Text.AlignLeft

}

// -------------------------------------------------------------------------------------------- 1. BOX

OverviewBoxMaxxFan{
		id: maxxfanHumidity

		x: 10
		y: 60
		width: 140
		height: 60

		MbIcon {
					iconId: "rb_humidity"
					x:10
					y:15
					width: 32
					height: 32
					}

		TileText
					{
						text: (maxxfan_humidity.value + maxxfan_humidity_offset.value).toFixed(0) + ""
						font.pixelSize: 35
						font.bold: true
						horizontalAlignment: Text.AlignRight

						anchors{
						top: parent.top; topMargin: 10
						right: parent.right; rightMargin: 26
						}

					}


					TileText
								{
									text: "%"
									x: 120
									y: 20
									font.pixelSize: 18
									font.bold: true
									horizontalAlignment: Text.AlignRight
									anchors{
									top: parent.top; topMargin: 14
									right: parent.right; rightMargin: 5
									}
								}


}

 //----------------------------------------------------------------------------- Anzeige Innentemperatur

 OverviewBoxMaxxFan{
		id: maxxfanTempInside
			 x: 10
			 y: 130
			 width: 140
			 height: 60

	 MbIcon {
				 iconId: "rb_temp_inside"
				 x:10
				 y:15
				 width: 44
				 height: 32
				 }

	 Rectangle {
				clip: true
				x: 68
				y: 10
				width: 50
				height: 35
				color: "#224563"

			TileText
						{
							text: (maxxfan_temperature.value + maxxfan_temperature_offset.value).toFixed(1)
							font.pixelSize: 35
							font.bold: true
							horizontalAlignment: Text.AlignRight
							anchors{
							right: parent.right; rightMargin: -34
							}

						}
					}


 			TileText
						{
							text: "°"
							x: 120
							y: 20
							font.pixelSize: 35
							font.bold: true
							horizontalAlignment: Text.AlignRight
							anchors{
								top: parent.top; topMargin: 10
								right: parent.right; rightMargin: 5
							}
						}

			Rectangle {
							clip: true
							x: 120
							y: 30
							width: 10
							height: 30
							color: "#224563"

							TileText {
											text: (maxxfan_temperature.value + maxxfan_temperature_offset.value).toFixed(1)
											opacity: 0.2
											horizontalAlignment: Text.AlignRight
											}
								}
}


 //------------------------ Anzeige Außentemperatur

 OverviewBoxMaxxFan{
	 id: trumaTempOutside

	 x: 10
	 y: 200
	 width: 140
	 height: 60

	 MbIcon {
				 iconId: "rb_temp_outside"
				 x:10
				 y:15
				 width: 44
				 height: 32
				 }

Rectangle {
				clip: true
				x: 68
				y: 10
				width: 50
				height: 35
				color: "#224563"

			TileText
						{
							text: sensorTempOutside.value.toFixed(1)
							font.pixelSize: 35
							font.bold: true
							horizontalAlignment: Text.AlignRight
							anchors{
							right: parent.right; rightMargin: -34
							}

						}
					}


 			TileText
						{
							text: "°"
							x: 120
							y: 20
							font.pixelSize: 35
							font.bold: true
							horizontalAlignment: Text.AlignRight
							anchors{
							top: parent.top; topMargin: 10
							right: parent.right; rightMargin: 5
							}
						}

						Rectangle {
							clip: true
							x: 120
							y: 30
							color: "#224563"
							width: 10
							height: 30
							TileText{
								text: sensorTempOutside.value.toFixed(1)
								opacity: 0.2
								horizontalAlignment: Text.AlignRight
							}

						}

}


// -------------------------------------------------------------------------------------------- 2. BOX (Temperatur)

OverviewBoxMaxxFan{
	id: secondBox

	x: 160
	y: 60
	width: 75
	height: 200


	MbIcon {
				iconId: "rb_temperature"
				y: 8
				rotation: 0
				width: 30
				height: 30
				opacity: maxxfan_status_automode.value == 1 ? 1 : 0.4
				anchors{
					horizontalCenter: secondBox.horizontalCenter
				}
				}

MouseArea {
	x: 3
	y: 50
	width:70
	height:40
	enabled: setTemperature != fanTemperature
	onClicked: {
		setTemperature = fanTemperature
		maxxfan_set_temperature.setValue(setTemperature)
		maxxfan_status_temperature.setValue(fanTemperature)
	}

Rectangle {
	color:"orange"
	width:68
	height:40
	//opacity: 0.4
	radius: width * 0.1
	visible: setTemperature != fanTemperature
}
}

TileText
				{
					y: 50
					opacity: maxxfan_status_automode.value == 1 ? 1 : 0.4
					text: fanTemperature
					font.pixelSize: 35
					font.bold: true
				}


MouseArea {
	x:10
	y:95
	width: 55
	height: 55
	enabled: maxxfan_status_automode.value  == 1
  onClicked: {
			if (fanTemperature < 37)
			return fanTemperature = (fanTemperature + 1)
	}
}
	MbIcon {
				iconId: "rb_button_plus"
				rotation: 0
				x:10
				y:95
				opacity: (fanTemperature < 37 ? 1 : 0.4) && (maxxfan_status_automode.value == 1 ? 1 : 0.4)
				width: 55
				height: 55
				}

MouseArea {
	x:10
	y:140
	width: 55
	height: 55
	enabled: maxxfan_status_automode.value  == 1
  onClicked: {
			if (fanTemperature > -2)
			return fanTemperature = (fanTemperature - 1)
	}
}
	MbIcon {
				iconId: "rb_button_minus"
				rotation: 0
				x:10
				y:140
				opacity: (fanTemperature > -2 ? 1 : 0.4) && (maxxfan_status_automode.value == 1 ? 1 : 0.4)
				width: 55
				height: 55
				}




}



// -------------------------------------------------------------------------------------------- 3. BOX (Lüftergeschwindigkeit)

OverviewBoxMaxxFan{
	id: thirdBox

	x: 245
	y: 60
	width: 75
	height: 200


	MbIcon {
				id: rb_ventilator
				iconId: "rb_ventilator"
				y: 8
				rotation: 0
				width: 30
				height: 30
				anchors{
					horizontalCenter: thirdBox.horizontalCenter
				}
				}

// Animation for the rb_ventilator icon -> AIR-OUT (rechts)
    RotationAnimation {
        target: rb_ventilator
        property: "rotation"
				from: 0
        to: 360
				duration: (4000 / maxxfan_set_fanspeed.value) * 2
				running: maxxfan_status_airflow.value == "out" && maxxfan_set_fanspeed.value > 0 && image_animation.value == 1
				loops: Animation.Infinite
    }

// Animation for the rb_ventilator icon -> AIR-IN (links)
    RotationAnimation {
        target: rb_ventilator
        property: "rotation"
				from: 360
        to: 0
				duration: (4000 / maxxfan_set_fanspeed.value) * 2
				running: maxxfan_status_airflow.value == "in" && maxxfan_set_fanspeed.value > 0 && image_animation.value == 1
				loops: Animation.Infinite
    }


MouseArea {
	x: 4
	y: 50
	width:70
	height:40
	enabled: maxxfan_set_fanspeed.value != maxxfan_status_fanspeed.value && maxxfan_status_automode.value == 0


onClicked: {
    maxxfan_set_fanspeed.setValue (maxxfan_status_fanspeed.value);
    if (maxxfan_status_fanspeed.value > 0) {
        maxxfan_ir_signal.setValue(maxxfan_status_airflow.text + "_" + maxxfan_status_fanspeed.value);
        maxxfan_status_fanspeed.setValue(maxxfan_status_fanspeed.value);
				maxxfan_status_open.setValue(1);
    } else if (maxxfan_status_fanspeed.value == 0) {
        maxxfan_ir_signal.setValue("fan_off");
        maxxfan_status_fanspeed.setValue(0);
				maxxfan_set_fanspeed.value = 0;
    }
}

Rectangle {
	color:"orange"
	width: 68
	height: 40
	opacity: maxxfan_status_automode.value  == 1 ? 0.0 : 1.0
	radius: width * 0.1
	visible: maxxfan_set_fanspeed.value != maxxfan_status_fanspeed.value
}
}


	TileText
				{
					y: 50
					text: maxxfan_status_fanspeed.value
					font.pixelSize: 35
					font.bold: true
				}


MouseArea {
	x:10
	y:95
	width: 55
	height: 55
  enabled: maxxfan_status_automode.value == 0
  onClicked: {
			if (maxxfan_status_fanspeed.value < 10)
			return maxxfan_status_fanspeed.setValue (maxxfan_status_fanspeed.value + 1)
	}
}

	MbIcon {
				iconId: "rb_button_plus"
				rotation: 0
				x:10
				y:95
				width: 55
				height: 55
				opacity: maxxfan_status_fanspeed.value < 10 && maxxfan_status_automode.value == 0 ? 1 : 0.4

				}

MouseArea {
	x:10
	y:140
	width: 55
	height: 55
  enabled: maxxfan_status_automode.value  == 0
  onClicked: {
			if (maxxfan_status_fanspeed.value > 0)
			return maxxfan_status_fanspeed.setValue (maxxfan_status_fanspeed.value - 1)
	}
}
	MbIcon {
				iconId: "rb_button_minus"
				rotation: 0
				x:10
				y:140
				opacity: maxxfan_status_fanspeed.value > 0 && maxxfan_status_automode.value == 0 ? 1 : 0.4
				width: 55
				height: 55
				}



}



// -------------------------------------------------------------------------------------------- 4. BOX

OverviewBoxMaxxFan{
	id: fourthBox

	x: 330
	y: 160
	width: 140
	height: 100

Button{
					id: button_set_auto_on
					//x: 380
					y: 10
					width: 120
					height: 30
					radius: 5
					baseColor: maxxfan_status_automode.value  == 1 ? "#3399ff" : "#4C6981"


					anchors{
						horizontalCenter: fourthBox.horizontalCenter
					}

					onClicked: {
						if (maxxfan_status_automode.value === 0){
							maxxfan_status_automode.setValue (1)
						}
						else if (maxxfan_status_automode.value === 1){
							maxxfan_status_automode.setValue (0)
							}
						}



					TileText {
						text: "AUTO"
						font.pixelSize: 12
						font.bold: true
						color: maxxfan_status_automode.value  == 1 ? "#ffffff" : "#ffffff"
						anchors{
							horizontalCenter: button_set_auto_on.horizontalCenter
							verticalCenter: button_set_auto_on.verticalCenter
							}
					}

				}


// AIR IN OUT

Button{
					id: button_air_in
					x: 10
					y: 50
					width: 55
					height: 40
					radius: 5
					baseColor: (maxxfan_status_airflow.value  == "in") ? "#3399ff" : "#4C6981"

					onClicked: {
							 maxxfan_status_airflow.setValue ("in")
							 if (maxxfan_status_fanspeed.value > 0){
							 			maxxfan_ir_signal.setValue ("in_" + maxxfan_status_fanspeed.getValue())
									}
							}



					TileText {
						text: "AIR\nIN"
						font.pixelSize: 12
						font.bold: true
						color: maxxfan_status_airflow.value  == "in" ? "#ffffff" : "#ffffff"
						anchors{
							horizontalCenter: button_air_in.horizontalCenter
							verticalCenter: button_air_in.verticalCenter
							}
					}

				}

// AIR OUT

Button{
					id: button_air_out
					x: 75
					y: 50
					width: 55
					height: 40
					radius: 5
					baseColor: (maxxfan_status_airflow.value  == "out") ? "#3399ff" : "#4C6981"

					onClicked: {
							 maxxfan_status_airflow.setValue ("out")
							 if (maxxfan_status_fanspeed.value > 0){
							 			maxxfan_ir_signal.setValue ("out_" + maxxfan_status_fanspeed.getValue())
						 		}
							}



					TileText {
						text: "AIR\nOUT"
						font.pixelSize: 12
						font.bold: true
						color: maxxfan_status_airflow.value  == "out" ? "#ffffff" : "#ffffff"
						anchors{
							horizontalCenter: button_air_out.horizontalCenter
							verticalCenter: button_air_out.verticalCenter
							}
					}

				}
}

// -------------------------------------------------------------------------------------------- 5. BOX

OverviewBoxMaxxFan{
	id: fifthBox

	x: 330
	y: 60
	width: 140
	height: 90


//--------------------------------------------------------------- FIXED static Images

		 MbIcon {
					 iconId: "rb_maxxfan_icon_open"
					 rotation: 0
					 x: 10
					 y: 10
					 visible: maxxfan_status_open.value == 1 && image_animation.value == 0
					 width: 80
					 height: 36
					 anchors{
	 					horizontalCenter: fifthBox.horizontalCenter
	 				}
					 }


		 MbIcon {
					 iconId: "rb_maxxfan_icon_closed"
					 rotation: 0
					 x: 10
					 y: 25
					 visible: maxxfan_status_open.value == 0 && image_animation.value == 0
					 width: 80
					 height: 21
					 anchors{
	 					horizontalCenter: fifthBox.horizontalCenter
	 				}
					 }

//--------------------------------------------------------------- FIXED static Images END


//--------------------------------------------------------------- ANIMATED Images

					 Rectangle {
					 	        id: arrowContainer
					 	        x: 90
					 	        y: 18 //25
					 	        width: 20
					 	        height: 10
					 	        color: "transparent"

					 	        MbIcon {
					 	            id: rb_in_out_arrow
					 	            iconId: "rb_in_out_arrow_blue"
					 	            rotation: (maxxfan_status_airflow.value == "out") ? 0 : 180
					 	            x: arrowContainer.width - width / 3
					 	            y: arrowContainer.height / 2 - height / 3
					 	            visible: maxxfan_set_fanspeed.value > 0 && image_animation.value == 1
					 	            width: 25
					 	            height: 20

					 							// Animationsparameter für "out"
					 					NumberAnimation {
					 							id: arrowAnimationOut
					 							target: rb_in_out_arrow
					 							property: "x"
					 							from: -rb_in_out_arrow.width
					 							to: arrowContainer.width
					 							duration: 4000 / maxxfan_set_fanspeed.value * 2
					 							loops: Animation.Infinite
					 							running: maxxfan_status_airflow.value == "out" && maxxfan_set_fanspeed.value > 0 && image_animation.value == 1
					 					}

					 					// Animationsparameter für "in"
					 					NumberAnimation {
					 							id: arrowAnimationIn
					 							target: rb_in_out_arrow
					 							property: "x"
					 							from: arrowContainer.width
					 							to: -rb_in_out_arrow.width
					 							duration: 4000 / maxxfan_set_fanspeed.value * 2
					 							loops: Animation.Infinite
					 							running: maxxfan_status_airflow.value == "in" && maxxfan_set_fanspeed.value > 0 && image_animation.value == 1
					 					}


					 	        }
					 	    }


								Rectangle {
											y:10
											width: 38
											height:30
											color: "#224563"
											visible: image_animation.value == 1
											anchors{
									 					horizontalCenter: fifthBox.horizontalCenter
									 				}
												}



					 MbIcon {
					 						 id: maxx_fan_icon_lid_bottom
					 					 					 					 iconId: "rb_maxxfan_lid_bottom"
					 					 					 					 rotation: 355
					 					 					 					 x: -57
					 					 					 					 y: 21
					 					 					 					 visible: image_animation.value == 1
					 					 					 					 width: 175
					 					 					 					 height: 30
					 					 					 					 }

 														RotationAnimation {
															         target: maxx_fan_icon_lid_bottom
															         property: "rotation"
															 				from: 355
															         to: 345
															 				duration: 4000
															 				running: maxxfan_status_open.value == 1 && image_animation.value == 1
															     }
														RotationAnimation {
															         target: maxx_fan_icon_lid_bottom
															         property: "rotation"
															 				from: 345
															         to: 355
															 				duration: 6000
															 				running: maxxfan_status_open.value == 0 && image_animation.value == 1
															     }



					 Rectangle {
						 x:20
						 y:35
						 width:100
						 height: 3
						 color: "#224563"
						 visible: image_animation.value == 1
					 }

					 Rectangle {
					 						 x:80
					 						 y:38
					 						 width:30
					 						 height: 5
					 						 color: "#224563"
											 visible: image_animation.value == 1
					 					 }


Rectangle {
						 x:20
						 y:44
						 width:100
						 height: 5
						 color: "#224563"
						 visible: image_animation.value == 1
					 }




					 MbIcon {
						 id: maxx_fan_icon_lid_animation
					 					 					 iconId: "rb_maxxfan_lid_only"
					 					 					 rotation: 360
					 					 					 x: -55
					 					 					 y: 19
					 					 					 visible: image_animation.value == 1
					 					 					 width: 175
					 					 					 height: 25
					 					 					 }


															 RotationAnimation {
															         target: maxx_fan_icon_lid_animation
															         property: "rotation"
															 				from: 360
															         to: 345
															 				duration: 6000
															 				running: maxxfan_status_open.value == 1 && image_animation.value == 1
															     }


																	 RotationAnimation {
																	         target: maxx_fan_icon_lid_animation
																	         property: "rotation"
																	 				from: 345
																	         to: 360
																	 				duration: 5000
																	 				running: maxxfan_status_open.value == 0 && image_animation.value == 1
																	     }


MbIcon {
					 iconId: "rb_maxxfan_icon_base"
					 rotation: 0
					 x: 10
					 y: 21
					 visible: image_animation.value == 1
					 width: 80
					 height: 25
					 anchors{
	 					horizontalCenter: fifthBox.horizontalCenter
	 				}
					 }

//--------------------------------------------------------------- ANIMATED Images END

					 // AIR IN OUT

					 Button{
					 					id: button_closed
					 					x: 10
					 					y: 55
					 					width: 55
					 					height: 25
					 					radius: 5
					 					baseColor: maxxfan_status_open.value  == 0 && maxxfan_set_fanspeed.value == 0 ? "#3399ff" : "#4C6981"

					 					onClicked: {
					 							 maxxfan_status_open.setValue (0)
												 maxxfan_ir_signal.setValue ("close")
												 maxxfan_set_fanspeed.setValue (0)
												 maxxfan_status_automode.setValue (0)
												 maxxfan_status_fanspeed.setValue (0)
					 							}



					 					TileText {
					 						text: "ZU"
					 						font.pixelSize: 12
					 						font.bold: true
					 						color: maxxfan_status_open.value  == 0 && maxxfan_set_fanspeed.value == 0 ? "#ffffff" : "#ffffff"
					 						anchors{
					 							horizontalCenter: button_closed.horizontalCenter
					 							verticalCenter: button_closed.verticalCenter
					 							}
					 					}

					 				}

					 // AIR OUT

					 Button{
					 					id: button_open
					 					x: 75
					 					y: 55
					 					width: 55
					 					height: 25
					 					radius: 5
					 					enabled: maxxfan_status_open.value == 0
										baseColor: maxxfan_status_open.value  == 1 || maxxfan_set_fanspeed.value > 0 ? "#3399ff" : "#4C6981"

					 					onClicked: {
											maxxfan_status_open.setValue (1)
											maxxfan_ir_signal.setValue ("open")
					 							}

					 					TileText {
					 						text: "AUF"
					 						font.pixelSize: 12
					 						font.bold: true
					 						color: maxxfan_status_open.value  == 1 || maxxfan_set_fanspeed.value > 0 ? "#ffffff" : "#ffffff"
					 						anchors{
					 							horizontalCenter: button_open.horizontalCenter
					 							verticalCenter: button_open.verticalCenter
					 							}
					 					}

					 				}

	TileText
				{
					y: 13
					text: ""
					font.pixelSize: 30
					font.bold: true
				}

}


	Text {
		text: qsTr("MaxxFan nicht gefunden")
		font.pixelSize: 25
		anchors.centerIn: parent
		visible: false
		color: "white"
	}

}
