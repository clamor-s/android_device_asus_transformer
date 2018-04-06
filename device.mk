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

# the actual meat of the device-specific product definition
$(call inherit-product, device/asus/transformer/device-common.mk)

PRODUCT_COPY_FILES += \
    device/asus/transformer/rootdir/fstab.transformer:root/fstab.transformer \
    device/asus/transformer/rootdir/init.transformer.rc:root/init.transformer.rc \
    device/asus/transformer/rootdir/init.transformer.sensors.rc:root/init.transformer.sensors.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=wifi-only

DEVICE_PACKAGE_OVERLAYS += \
    device/asus/transformer/overlay
