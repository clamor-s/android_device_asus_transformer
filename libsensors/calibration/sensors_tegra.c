/*
 * Copyright (C) 2018 Unlegacy Android Project
 * Copyright (C) 2018 Svyatoslav Ryhel
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "SensorsCal"

#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

#include <cutils/log.h>

/* Sensors definitions */
#define LIGHT_NAM "Lite-On AL3010 Ambient Light Sensor"
#define LIGHT_INI "/per/lightsensor/AL3010_Config.ini"
#define LIGHT_CAL "/sys/devices/platform/tegra-i2c.2/i2c-2/2-001c/calibration"

int calibrateSensor(const char *path1, const char *path2, const char *name)
{
    char buffer[20] = {0};
    int file, err;

    /* Read values from calibration file */
    file = open(path1, O_RDONLY);
    if (file < 0) {
        ALOGI("Failed to open calibration file %s\n", path1);
        return 0;
    }

    err = read(file, buffer, sizeof(buffer));
    close(file);
    if (err <= 0) {
        ALOGE("Failed to read calibration data.\n");
        return -EIO;
    }

    /* Apply values to device */
    file = open(path2, O_RDWR);
    if (file < 0) {
        ALOGE("Failed to open target file %s\n", path2);
        return -ENOENT;
    }

    err = write(file, buffer, sizeof(buffer));
    close(file);
    if (err <= 0) {
        ALOGE("Failed to write calibration data.\n");
        return -EIO;
    }

    ALOGI("%s calibrated successfully\n", name);
    return 0;
}

int main(void)
{
    calibrateSensor(LIGHT_INI, LIGHT_CAL, LIGHT_NAM);
    return 0;
}
