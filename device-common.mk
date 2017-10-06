#
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, hardware/nvidia/tegra3/tegra3.mk)

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG := xlarge
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Dalvik VM config
$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

# Init files
PRODUCT_COPY_FILES += \
    device/asus/transformer/rootdir/init.transformer.usb.rc:root/init.transformer.usb.rc \
    device/asus/transformer/rootdir/ueventd.transformer.rc:root/ueventd.transformer.rc

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Input device configs
PRODUCT_COPY_FILES += \
    device/asus/transformer/touchscreen/atmel-maxtouch.idc:system/usr/idc/atmel-maxtouch.idc \
    device/asus/transformer/touchscreen/elantech_touchscreen.idc:system/usr/idc/elantech_touchscreen.idc \
    device/asus/transformer/touchscreen/elan-touchscreen.idc:system/usr/idc/elan-touchscreen.idc \
    device/asus/transformer/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/asus/transformer/keylayout/asusdec.kl:system/usr/keylayout/asusdec.kl \
    device/asus/transformer/keylayout/asusdec.kcm:system/usr/keychars/asusdec.kcm

# GPS
PRODUCT_COPY_FILES += \
    device/asus/transformer/gps/gps.conf:system/etc/gps.conf \
    device/asus/transformer/gps/gps.xml:system/etc/gps.xml

PRODUCT_PACKAGES += \
    libgpsd-compat \
    libstlport

# Wi-Fi
PRODUCT_COPY_FILES += \
    device/asus/transformer/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    device/asus/transformer/wifi/nvram_nh615.txt:$(TARGET_COPY_OUT_VENDOR)/etc/nvram_nh615.txt \
    device/asus/transformer/wifi/nvram_nh665.txt:$(TARGET_COPY_OUT_VENDOR)/etc/nvram_nh665.txt

PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    wificond \
    wpa_supplicant \
    wpa_supplicant.conf

WIFI_BAND := 802_11_BG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    libbt-vendor

# Lights HAL
PRODUCT_PACKAGES += \
    lights.transformer

# Sensors HAL
PRODUCT_PACKAGES += \
    sensors.transformer \
    libmllite \
    libmplmpu \
    libmlplatform \
    libsensors.base \
    libsensors.mpl

PRODUCT_COPY_FILES += \
    device/asus/transformer/sensors/sensors-load-calibration.sh:system/bin/sensors-load-calibration.sh

# Audio HAL
PRODUCT_PACKAGES += \
    audio.primary.transformer \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

PRODUCT_COPY_FILES += \
    device/asus/transformer/audio/audio_policy.conf:system/etc/audio_policy.conf \
    device/asus/transformer/audio/mixer_rt5631.xml:system/etc/mixer_rt5631.xml \
    device/asus/transformer/audio/mixer_wm8903.xml:system/etc/mixer_wm8903.xml

# Filesystem management tools
PRODUCT_PACKAGES += \
    fsck.f2fs \
    mkfs.f2fs

# Shell
ifneq ($(filter eng userdebug,$(TARGET_BUILD_VARIANT)),)
PRODUCT_PACKAGES += \
    Terminal
endif

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    device/asus/transformer/media/media_profiles.xml:system/etc/media_profiles.xml \
    device/asus/transformer/media/media_codecs.xml:system/etc/media_codecs.xml

# Vendor blobs
$(call inherit-product, vendor/asus/transformer/asus-vendor.mk)
$(call inherit-product, vendor/broadcom/transformer/broadcom-vendor.mk)
