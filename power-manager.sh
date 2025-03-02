#!/bin/bash

# Function to get System Performance Mode
get_performance_mode() {
    echo '\_SB.PCI0.LPC0.EC0.GZ44' > /proc/acpi/call
    mode=$(cat /proc/acpi/call)
    case "$mode" in
        0x0) echo "Intelligent Cooling" ;;
        0x1) echo "Extreme Performance" ;;
        0x2) echo "Battery Saving" ;;
        *) echo "Unknown" ;;
    esac
}

# Function to set System Performance Mode
set_performance_mode() {
    case "$1" in
        "Intelligent Cooling") echo '\_SB_.GZFD.WMAA 0 0x2C 2' > /proc/acpi/call ;;
        "Extreme Performance") echo '\_SB_.GZFD.WMAA 0 0x2C 3' > /proc/acpi/call ;;
        "Battery Saving") echo '\_SB_.GZFD.WMAA 0 0x2C 1' > /proc/acpi/call ;;
    esac
    zenity --info --text="System Performance Mode set to $(get_performance_mode)" --width=800 --height=200
}

# Function to toggle Rapid Charge
toggle_rapid_charge() {
    echo '\_SB.PCI0.LPC0.EC0.FCGM' > /proc/acpi/call
    status=$(cat /proc/acpi/call)
    if [[ "$status" == "0x0" ]]; then
        echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' > /proc/acpi/call
        zenity --info --text="Rapid Charge Enabled" --width=500 --height=200
    else
        echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' > /proc/acpi/call
        zenity --info --text="Rapid Charge Disabled" --width=500 --height=200
    fi
}

# Function to toggle Battery Conservation Mode
toggle_battery_conservation() {
    echo '\_SB.PCI0.LPC0.EC0.BTSM' > /proc/acpi/call
    status=$(cat /proc/acpi/call)
    if [[ "$status" == "0x0" ]]; then
        echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' > /proc/acpi/call
        zenity --info --text="Battery Conservation Mode Enabled" --width=500 --height=200
    else
        echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x05' > /proc/acpi/call
        zenity --info --text="Battery Conservation Mode Disabled" --width=500 --height=200
    fi
}

# Main menu
while true; do
    choice=$(zenity --list --title="akshats IG3 Control" --column="Options" --width=600 --height=400 \
        "Set System Performance Mode" \
        "Toggle Rapid Charge" \
        "Toggle Battery Conservation" \
        "Exit")

    # Exit the script if Cancel is pressed or no choice is made
    if [[ -z "$choice" ]]; then
        exit
    fi

    case "$choice" in
        "Set System Performance Mode")
            mode=$(zenity --list --title="Select Performance Mode" --column="Modes" --width=800 --height=400 \
                "Intelligent Cooling" "Extreme Performance" "Battery Saving")
            
            # Return to main menu if Cancel is pressed
            if [[ -z "$mode" ]]; then
                continue
            fi

            set_performance_mode "$mode"
            ;;
        "Toggle Rapid Charge") toggle_rapid_charge ;;
        "Toggle Battery Conservation") toggle_battery_conservation ;;
        "Exit") exit ;;
    esac
done


