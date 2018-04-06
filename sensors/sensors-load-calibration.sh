#!/system/bin/sh

# AL3010 Ambient Light Sensor calibration data
if [ -f /per/lightsensor/AL3010_Config.ini ]; then
    cat /per/lightsensor/AL3010_Config.ini > /sys/devices/platform/tegra-i2c.2/i2c-2/2-001c/calibration
fi
