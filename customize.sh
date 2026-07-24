#!/system/bin/sh

ui_print "**********************************************"
ui_print "*   Universal Dynamic GNSS & GPS Optimizer   *"
ui_print "*             for Magisk / KSU               *"
ui_print "**********************************************"
ui_print ""

# ----------------------------------------------------
# 1. CHIPSET DETECTION
# ----------------------------------------------------
ui_print "[*] Detecting Hardware & Chipset..."

SOC_MANUFACTURER=$(getprop ro.soc.manufacturer | tr '[:upper:]' '[:lower:]')
HARDWARE=$(getprop ro.hardware | tr '[:upper:]' '[:lower:]')
BOARD=$(getprop ro.board.platform | tr '[:upper:]' '[:lower:]')

CHIPSET="qcom" # Default fallback

if [ "$SOC_MANUFACTURER" = "mediatek" ] || echo "$HARDWARE $BOARD" | grep -qE "mt|mediatek"; then
    CHIPSET="mtk"
    ui_print "    -> Detected: MediaTek Chipset"
elif [ "$SOC_MANUFACTURER" = "qti" ] || [ "$SOC_MANUFACTURER" = "qualcomm" ] || echo "$HARDWARE $BOARD" | grep -qE "qcom|qualcomm|sm|sdm|msm"; then
    CHIPSET="qcom"
    ui_print "    -> Detected: Qualcomm Snapdragon Chipset"
else
    ui_print "    -> Unknown Chipset ($HARDWARE / $BOARD). Falling back to Universal Qualcomm Profile."
fi

# ----------------------------------------------------
# 2. ARCHITECTURE DETECTION
# ----------------------------------------------------
ui_print "[*] Detecting CPU Architecture..."
ABI=$(getprop ro.product.cpu.abi)
ui_print "    -> Architecture: $ABI"

# ----------------------------------------------------
# 3. REGION / LOCALE DETECTION
# ----------------------------------------------------
ui_print "[*] Detecting Region & Timezone..."

COUNTRY=$(getprop ro.product.locale)
TIMEZONE=$(getprop persist.sys.timezone)

REGION="global" # Default fallback

if echo "$COUNTRY $TIMEZONE" | grep -qE -i "asia|dhaka|tokyo|shanghai|kolkata|jakarta|bangkok|singapore|IN|BD|CN|JP|ID|TH|MY|VN"; then
    REGION="asia"
    ui_print "    -> Region Selected: Asia"
elif echo "$COUNTRY $TIMEZONE" | grep -qE -i "europe|london|paris|berlin|rome|moscow|EEA|EU"; then
    REGION="europe"
    ui_print "    -> Region Selected: Europe"
elif echo "$COUNTRY $TIMEZONE" | grep -qE -i "america|new_york|chicago|los_angeles|US|CA|BR"; then
    REGION="america"
    ui_print "    -> Region Selected: Americas"
else
    ui_print "    -> Region Selected: Global (Fallback)"
fi

# ----------------------------------------------------
# 4. DYNAMIC INSTALLATION (FIXED)
# ----------------------------------------------------
ui_print "[*] Injecting optimized GPS configuration..."

# 1. Unpack all configs into TMPDIR first so we can run file checks [-f]
unzip -o "$ZIPFILE" "configs/*" -d "$TMPDIR" >/dev/null 2>&1

TARGET_CONFIG="$TMPDIR/configs/$CHIPSET/$REGION.conf"
FALLBACK_CONFIG="$TMPDIR/configs/$CHIPSET/default.conf"

# 2. Check if region config exists, otherwise fall back to default.conf
if [ -f "$TARGET_CONFIG" ]; then
    FINAL_SOURCE="$TARGET_CONFIG"
elif [ -f "$FALLBACK_CONFIG" ]; then
    ui_print "    -> Region file missing. Falling back to default.conf"
    FINAL_SOURCE="$FALLBACK_CONFIG"
else
    ui_print "    [!] Error: No valid config file found!"
    exit 1
fi

# 3. Create target directories inside module path
mkdir -p "$MODPATH/system/etc"
mkdir -p "$MODPATH/system/vendor/etc"

# 4. Copy selected config into module systemless paths
cp -af "$FINAL_SOURCE" "$MODPATH/system/etc/gps.conf"
cp -af "$FINAL_SOURCE" "$MODPATH/system/vendor/etc/gps.conf"

ui_print "    -> Successfully applied $CHIPSET configuration!"

# ----------------------------------------------------
# 5. SET PERMISSIONS
# ----------------------------------------------------
set_perm_recursive "$MODPATH" 0 0 0755 0644

ui_print ""
ui_print "[✓] Installation Complete!"
ui_print "[!] Please reboot your device to apply changes."
