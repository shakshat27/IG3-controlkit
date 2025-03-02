# Lenovo Control GUI

A simple GUI tool using **Zenity** to manage Lenovo laptop settings, including:
* **System Performance Modes** (Intelligent Cooling, Extreme Performance, Battery Saving)
* **Rapid Charge toggle**
* **Battery Conservation Mode toggle**

## Features

| Feature | Available Modes / Actions | ACPI Call Command |
|---------|---------------------------|-------------------|
| **System Performance Mode** | Intelligent Cooling, Extreme Performance, Battery Saving | `\_SB_.GZFD.WMAA 0 0x2C [MODE]` |
| **Rapid Charge** | Enable / Disable | `\_SB.PCI0.LPC0.EC0.VPC0.SBMC [VALUE]` |
| **Battery Conservation Mode** | Enable / Disable | `\_SB.PCI0.LPC0.EC0.VPC0.SBMC [VALUE]` |

## Installation

### 1. Install Required Dependencies

Ensure `acpi_call` and `zenity` are installed:

```
sudo pacman -S acpi_call zenity
```

### 2. Clone the Repository

```
git clone https://github.com/YOUR_USERNAME/Lenovo-Control-GUI.git
cd Lenovo-Control-GUI
chmod +x power-manager.sh
```

### 3. Run the Script

Launch the script with:

```
sudo ./power-manager.sh
```

### 4. Add to Applications Menu (Optional)

To integrate it into your system's application menu:

```
cp power-manager.desktop ~/.local/share/applications/
```

You can now launch it from your applications menu.

## System Performance Mode

There are three modes available: **Intelligent Cooling, Extreme Performance, and Battery Saving**. On some Lenovo IdeaPad models, these can also be toggled using the **Fn+Q** keyboard shortcut.

### Setting System Performance Mode via ACPI

To manually set the performance mode using ACPI calls:

* **Intelligent Cooling Mode**
```
echo '\_SB_.GZFD.WMAA 0 0x2C 2' > /proc/acpi/call
```

* **Extreme Performance Mode**
```
echo '\_SB_.GZFD.WMAA 0 0x2C 3' > /proc/acpi/call
```

* **Battery Saving Mode**
```
echo '\_SB_.GZFD.WMAA 0 0x2C 1' > /proc/acpi/call
```

### Checking Current System Performance Mode

For **15ARH05, 15ACH6**, and related models:
```
echo '\_SB.PCI0.LPC0.EC0.SPMO' > /proc/acpi/call
cat /proc/acpi/call; printf '\n'
```

For **15ACH6, 15ARH7**, and related models:
```
echo '\_SB.PCI0.LPC0.EC0.GZ44' > /proc/acpi/call
cat /proc/acpi/call; printf '\n'
```

The returned value corresponds to the following modes:

| Value | Mode |
|-------|------|
| 0x0 | Intelligent Cooling |
| 0x1 | Extreme Performance |
| 0x2 | Battery Saving |

## Rapid Charge

### Enabling and Disabling Rapid Charge

* **Enable Rapid Charge**
```
echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' > /proc/acpi/call
```

* **Disable Rapid Charge**
```
echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' > /proc/acpi/call
```

### Checking Rapid Charge Status

* **General models:**
```
echo '\_SB.PCI0.LPC0.EC0.QCHO' > /proc/acpi/call
cat /proc/acpi/call; printf '\n'
```

* **For some 15ACH6 models:**
```
echo '\_SB.PCI0.LPC0.EC0.FCGM' > /proc/acpi/call
cat /proc/acpi/call; printf '\n'
```

The output value:

| Value | Status |
|-------|--------|
| 0x0 | Off |
| 0x1 | On |

## Battery Conservation Mode

### Enabling and Disabling Battery Conservation Mode

* **Enable Battery Conservation Mode**
```
echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' > /proc/acpi/call
```

* **Disable Battery Conservation Mode**
```
echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x05' > /proc/acpi/call
```

### Checking Battery Conservation Mode Status

```
echo '\_SB.PCI0.LPC0.EC0.BTSM' > /proc/acpi/call
cat /proc/acpi/call; printf '\n'
```

The output value:

| Value | Status |
|-------|--------|
| 0x0 | Off |
| 0x1 | On |

Alternatively, for models supporting `ideapad_acpi`:

```
echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
```

Setting the value to `0` disables the feature.

## Troubleshooting

* **Permission Issues?** Ensure you run the script with `sudo`.
* **Changes Not Applying?** Check if `acpi_call` is loaded properly:
```
sudo modprobe acpi_call
```
* **Not Sure If It's Working?** Run the status check commands listed above after making changes.


## Contribute

Want to improve this project? Fork the repository and submit pull requests!
