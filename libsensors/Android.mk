#
# Copyright (C) 2008 The Android Open Source Project
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


LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libsensors.base
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\"
LOCAL_SRC_FILES := SensorBase.cpp SensorUtil.cpp InputEventReader.cpp
LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/mllite
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/linux
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/include/linux
LOCAL_SHARED_LIBRARIES := liblog libdl libcutils libutils
LOCAL_CPPFLAGS+=-DLINUX=1
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := sensors.tegra
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Wall -Werror
LOCAL_SRC_FILES := /calibration/sensors_tegra.c
LOCAL_SHARED_LIBRARIES := liblog libcutils
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := libmplmpu
LOCAL_SRC_FILES := /prebuilt/libmplmpu.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := invensense
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PROPRIETARY_MODULE := true
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
LOCAL_STRIP_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libmllite
LOCAL_SRC_FILES := /prebuilt/libmllite.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := invensense
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PROPRIETARY_MODULE := true
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
LOCAL_STRIP_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libmlplatform
LOCAL_SRC_FILES := /prebuilt/libmlplatform.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := invensense
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PROPRIETARY_MODULE := true
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
LOCAL_STRIP_MODULE := true
include $(BUILD_PREBUILT)

ifneq (,$(filter $(BOARD_USES_INVENSENSE_GYRO),INVENSENSE_MPU3050 INVENSENSE_MPU6050))

include $(CLEAR_VARS)
LOCAL_MODULE := libsensors.mpl
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\"
LOCAL_CFLAGS += -std=gnu++0x
LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/mllite
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/linux
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/include/linux
LOCAL_SRC_FILES := MPLSensorSysApi.cpp MPLSensor.cpp
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils libdl \
                          libmllite libmlplatform libmplmpu \
                          libsensors.base 
LOCAL_CPPFLAGS+=-DLINUX=1
ifeq	($(BOARD_USES_INVENSENSE_GYRO),INVENSENSE_MPU3050)
LOCAL_CPPFLAGS+=-DPLATFORM_H=\"mpu3050.h\"
endif # INVENSENSE_MPU3050
ifeq	($(BOARD_USES_INVENSENSE_GYRO),INVENSENSE_MPU6050)
LOCAL_CPPFLAGS+=-DPLATFORM_H=\"mpu6050b1.h\"
endif # INVENSENSE_MPU6050
LOCAL_CPPFLAGS += -DMPL_LIB_NAME=\"libmplmpu.so\"
include $(BUILD_SHARED_LIBRARY)

endif # BOARD_USES_INVENSENSE_GYRO

# HAL module implemenation stored in
# hw/<COPYPIX_HARDWARE_MODULE_ID>.<ro.board.platform>.so

include $(CLEAR_VARS)
LOCAL_MODULE := sensors.$(TARGET_BOOTLOADER_BOARD_NAME)
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\"
LOCAL_SRC_FILES := sensors.cpp LightSensor.cpp
LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/mllite
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/linux
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/mlsdk/platform/include/linux
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils libdl \
                          libsensors.base libsensors.mpl
LOCAL_CPPFLAGS+=-DLINUX=1
include $(BUILD_SHARED_LIBRARY)
