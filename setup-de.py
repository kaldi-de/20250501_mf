import subprocess
import os
import shutil
from datetime import datetime

directories = [
    '/data/RoadbuckMods',
    '/data/RoadbuckMods/MaxxFan',
    '/data/RoadbuckMods/MaxxFan/backup_files',
]

for directory in directories:
    if not os.path.exists(directory):
        os.makedirs(directory)
        print(f"Verzeichnis {directory} erstellt.")
    else:
        print(f"Verzeichnis {directory} existiert bereits.")

source_directory = '/data/MaxxFan/files'
destination_directory = '/data/RoadbuckMods/MaxxFan'

try:
    shutil.move(source_directory, destination_directory)
    print("Verzeichnis erfolgreich verschoben.")
except Exception as e:
    print(f"Fehler beim Verschieben des Verzeichnisses: {e}")

def set_file_permissions(file_path, permissions):
    try:
        os.chmod(file_path, permissions)
        print(f"Berechtigungen für {file_path} auf {permissions} gesetzt.")
    except Exception as e:
        print(f"Error setting permissions for {file_path}:\n{e}")

def run_bash_script(script_path):
    try:
        subprocess.run([script_path], check=True)
        print(f"Script {script_path} executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error executing script {script_path}:\n{e}")

if __name__ == "__main__":
    file_path = "/data/RoadbuckMods/MaxxFan/files/update_dbus_settings.sh"
    permissions = 0o755

    set_file_permissions(file_path, permissions)
    run_bash_script(file_path)

files_to_copy = [
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/RB_Menu.qml',
        'destination': '/opt/victronenergy/gui/qml/RB_Menu.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/RB_PageMaxxFan.qml',
        'destination': '/opt/victronenergy/gui/qml/RB_PageMaxxFan.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_OverviewMaxxFan.qml',
        'destination': '/opt/victronenergy/gui/qml/OverviewMaxxFan.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/OverviewBoxMaxxFan.qml',
        'destination': '/opt/victronenergy/gui/qml/OverviewBoxMaxxFan.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckMods.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckMods.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckStarterBattery.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckStarterBattery.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckTruma.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckTruma.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckMaxxFan.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckMaxxFan.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckShelly.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckShelly.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckTeltonika.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckTeltonika.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckWeather.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckWeather.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckRelayBox.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckRelayBox.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/qml/DE_PageSettingsRoadbuckEcoFlow.qml',
        'destination': '/opt/victronenergy/gui/qml/PageSettingsRoadbuckEcoFlow.qml'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_button_minus.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_button_minus.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_button_plus.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_button_plus.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_button_on.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_button_on.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_button_off.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_button_off.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_humidity.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_humidity.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_in_out_arrow_blue.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_in_out_arrow_blue.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_icon_base.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_icon_base.svg'
    },
    {
    'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_icon_closed.svg',
    'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_icon_closed.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_icon_open.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_icon_open.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_lid_bottom.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_lid_bottom.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_lid_only.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_lid_only.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_logo.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_logo.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_logo_c.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_logo_c.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_maxxfan_logo_neu.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_maxxfan_logo_neu.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_temp_inside.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_temp_inside.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_temp_outside.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_temp_outside.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_temperature.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_temperature.svg'
    },
    {
        'source': '/data/RoadbuckMods/MaxxFan/files/images/rb_ventilator.svg',
        'destination': '/opt/victronenergy/themes/ccgx/images/rb_ventilator.svg'
    },
]

for file_info in files_to_copy:
    source_path = file_info['source']
    destination_path = file_info['destination']

    if os.path.exists(destination_path):
        base_name, ext = os.path.splitext(destination_path)
        counter = 1
        new_destination_path = f"{base_name}_{counter}.rbm"

        while os.path.exists(new_destination_path):
            counter += 1
            new_destination_path = f"{base_name}_{counter}.rbm"

        os.rename(destination_path, new_destination_path)
        print(f"Die existierende Datei wurde umbenannt zu:\n{new_destination_path}")
        shutil.copy(source_path, destination_path)
        print(f"Die neue Datei wurde nach:\n{destination_path}\nkopiert.")
    else:
        shutil.copy(source_path, destination_path)
        print(f"Die Datei wurde von:\n{source_path}\nnach:\n{destination_path}\nkopiert.")

source_files = [
    '/opt/victronenergy/gui/qml/main.qml',
    '/opt/victronenergy/gui/qml/OverviewHub.qml',
    '/opt/victronenergy/gui/qml/OverviewHubEnhanced.qml',
    '/opt/victronenergy/gui/qml/PageSettingsDisplay.qml',
    '/opt/victronenergy/gui/qml/PageSettingsRoadbuckMaxxFan.qml',
    '/opt/victronenergy/gui/qml/OverviewMaxxFan.qml',
    '/opt/victronenergy/gui/qml/OverviewBoxMaxxFan.qml',
    '/opt/victronenergy/gui/qml/RB_Menu.qml',
]

destination_directory = '/data/RoadbuckMods/MaxxFan/backup_files'

current_datetime = datetime.now().strftime('%Y-%m-%d_%H-%M')
destination_directory_with_timestamp = os.path.join(destination_directory, current_datetime)

if not os.path.exists(destination_directory_with_timestamp):
    os.makedirs(destination_directory_with_timestamp)
    print(f"Verzeichnis {destination_directory_with_timestamp} angelegt.")

for file_path in source_files:
    file_name = os.path.basename(file_path)
    destination_path = os.path.join(destination_directory_with_timestamp, file_name)
    shutil.copy(file_path, destination_path)
    print(f"Datei {file_path} kopiert nach:\n{destination_path}")
