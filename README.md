#  Optimized GPS File Replacer For China Devices

- [ Optimized GPS File Replacer for China Devices](#optimized-gps-file-replacer-china-devices)
  - [How it works?](#how-it-works)
  - [Requirements](#requirements)
  - [Instructions](#instructions)
  - [Dev Note](#dev-note)
  - [Version 1.0](#version-10)
  - [Reference](#reference)

This module provides an improved GPS functionality with a better and faster accuracy location reference.

## How it works?
The stock android **_gps.conf_** file found in *"/system/etc/gps.conf"* or *"/system/vendor/etc/gps.conf"* is replaced with a new one correctly edited for a better improvement and faster satellite signals fix/lock.
This file is responsible for the correct GPS operation and functionality.
The default file found in most ROMs is very wrong and has a lot of bad information and settings for the correct operation and functionality of the GPS and A-GPS.

## Requirements
- A device with Qualcomm Snapdragon chipset based.
- Rooted with Magisk and Magisk Manager indeed installed.

## Instructions
__It's Root install-able, don't install it by TWRP but with Magisk instead!__

0. [Download](https://github.com/mrSnow-tr/CnOptmizedGPSConf/releases/latest/download/CnOptmizedGPSConf.zip)
1. Go to Magisk Manager **_Modules_** section.
2. Click on **_+_** yellow button and search/find for this **_"cnoptimizedgpsconf.zip"_** file and long press on it.
3. Select open and after installed then reboot your device.
4. After rebooted your device, make sure your location settings is setup on mode **_Device only_**.
5. Skirt outdoors, can be in the yard of your house or anywhere else with a line of sight to the sky and stay in that outdoor place.
6. Download some Compass app on Google Play Store *(I recommend the **Compass Steel 3D**)* and then calibrate the compass.
7. Download **_GPS Locker_** app on Google Play Store and open the app and wait for the first time fix/lock. *This is necessary and essential because the app will recognize some GPS satellites signals for the very first time.*

## Dev Note
# It's a Magisk module, if you want to use it in Ksu / Ksu-Next then install "Hybrid mount" module. Restart phone, then install this module. 

#### Version 1.0
- Use gps.conf for Cn HyperOS 
- Update README.md
- Add [release package](https://github.com/mrSnow-tr/CnOptmizedGPSConf/releases/latest/download/CnOptmizedGPSConf.zip)

## Reference
- [skyrocketingHong/OptmizedGPSConf](https://github.com/skyrocketingHong/OptmizedGPSConf)
- [Module XDA Xiaomi MI 5 Forum Thread](https://forum.xda-developers.com/mi-5/how-to/step-step-definitive-gps-solution-global-t3695769)
- [JonasCardoso/optmizedgpsconf](https://github.com/JonasCardoso/optmizedgpsconf)
