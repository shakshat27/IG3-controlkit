# Lenovo Control GUI

A simple GUI tool using **Zenity** to manage Lenovo laptop settings, including:  
✅ **System Performance Modes** (Intelligent Cooling, Extreme Performance, Battery Saving)  
✅ **Rapid Charge toggle**  
✅ **Battery Conservation Mode toggle**  

This tool leverages **ACPI calls** to adjust system settings without relying on proprietary Windows software.

---

## 📌 Features  

| Feature                     | Available Modes / Actions                        | ACPI Call Command |
|-----------------------------|--------------------------------------------------|-------------------|
| **System Performance Mode** | Intelligent Cooling, Extreme Performance, Battery Saving | `\_SB_.GZFD.WMAA 0 0x2C [MODE]` |
| **Rapid Charge**            | Enable / Disable                                | `\_SB.PCI0.LPC0.EC0.VPC0.SBMC [VALUE]` |
| **Battery Conservation Mode** | Enable / Disable                            | `\_SB.PCI0.LPC0.EC0.VPC0.SBMC [VALUE]` |

### 🎯 System Performance Mode

| Mode Name             | ACPI Value | Command |
|----------------------|------------|---------|
| **Intelligent Cooling** | `0x2`  | `echo '\_SB_.GZFD.WMAA 0 0x2C 2' > /proc/acpi/call` |
| **Extreme Performance** | `0x3`  | `echo '\_SB_.GZFD.WMAA 0 0x2C 3' > /proc/acpi/call` |
| **Battery Saving**      | `0x1`  | `echo '\_SB_.GZFD.WMAA 0 0x2C 1' > /proc/acpi/call` |

To check the current **System Performance Mode**, run:
```bash
echo '\_SB.PCI0.LPC0.EC0.GZ44' > /proc/acpi/call
cat /proc/acpi/call
