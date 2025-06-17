#!/system/bin/sh

# ==========================================
#  Universal System Optimizer - Magisk Module
#  Author: @saltfor (Telegram)
#  Version: 1.0
# ==========================================

# --- ASCII Art ---
ui_print " "
ui_print "  ██████╗ ██████╗ ███████╗██╗   ██╗"
ui_print " ██╔═══██╗██╔══██╗██╔════╝██║   ██║"
ui_print " ██║   ██║██████╔╝█████╗  ██║   ██║"
ui_print " ██║   ██║██╔═══╝ ██╔══╝  ██║   ██║"
ui_print " ╚██████╔╝██║     ██║     ╚██████╔╝"
ui_print "  ╚═════╝ ╚═╝     ╚═╝      ╚═════╝"
ui_print " "

# --- Initial Setup ---
ui_print "- Initializing..."
sleep 0.5

MODPATH_SYSTEM_PROP="$MODPATH"/system.prop
MOD_PROP_VERSION=$(grep_prop version "$MODPATH"/module.prop)
MOD_PROP_DEVICE=$(getprop ro.product.model)
MOD_PROP_ANDROID=$(getprop ro.build.version.release)

ui_print "  [DEVICE] $MOD_PROP_DEVICE"
ui_print "  [ANDROID] $MOD_PROP_ANDROID"
sleep 0.3

# --- Fancy Progress Animation ---
animate_progress() {
    text="$1"
    ui_print " "
    ui_print ">>> $text <<<"
    
    i=1
    while [ $i -le 5 ]; do
        progress=""
        j=1
        while [ $j -le $i ]; do
            progress="$progress▓"
            j=$((j + 1))
        done
        j=$i
        while [ $j -lt 5 ]; do
            progress="$progress░"
            j=$((j + 1))
        done
        
        ui_print "  [$i/5] $progress"
        sleep 0.2
        i=$((i + 1))
    done
    ui_print "  [✓] Done"
    sleep 0.3
}

# --- Main Optimization Process ---
ui_print " "
ui_print "==== STARTING OPTIMIZATION PROCESS ===="
sleep 1

# 1. System Tweaks
animate_progress "Applying System Tweaks"
setprop persist.sys.force_sw_gles 0
setprop ro.config.hw_quickpoweron true
setprop pm.dexopt.bg-dexopt speed-profile

# 2. Memory Optimization
animate_progress "Optimizing Memory"
setprop ro.config.fha_enable true
sleep 0.1

# 3. Network Boost
animate_progress "Boosting Network"
setprop net.tcp.buffersize.default 4096,87380,256960,4096,16384,256960
setprop net.ipv4.tcp_window_scaling 1
setprop net.ipv4.tcp_moderate_rcvbuf 1

# 5. Battery Optimization
animate_progress "Optimizing Battery"
cmd settings put global adaptive_battery_management_enabled 0
cmd settings put system intelligent_sleep_mode 0
cmd settings put secure adaptive_sleep 0

# --- Universal App Optimizations ---
ui_print " "
ui_print "==== OPTIMIZING SYSTEM APPS ===="
sleep 0.5

# Google Apps
ui_print " "
ui_print "  [DISABLING] Google Services:"
for pkg in \
    com.google.android.tts \
    com.google.android.syncadapters.calendar \
    com.google.android.googlequicksearchbox \
    com.google.android.partnersetup \
    com.google.android.gms.location.history
do
    pm disable-user "$pkg" >/dev/null 2>&1
    ui_print "    - $pkg"
    sleep 0.05
done

# System Apps
ui_print " "
ui_print "  [DISABLING] System Apps:"
for pkg in \
    com.android.egg \
    com.android.providers.calendar \
    com.android.hotwordenrollment.okgoogle \
    com.android.stk \
    com.android.printspooler
do
    pm disable-user "$pkg" >/dev/null 2>&1
    ui_print "    - $pkg"
    sleep 0.05
done

# --- Cleanup ---
animate_progress "Cleaning System Cache"
ui_print "  [CLEARING] Application caches..."
pm trim-caches 99999G
rm -rf /data/data/*/cache/*
rm -rf /sdcard/Android/data/*/cache/*
find /storage/emulated/0 -type d -empty -delete 2>/dev/null
ui_print "››CLEARING‹‹ /cache/"
rm -rf /cache/*
sleep 0.2
ui_print "››CLEARING‹‹ /tmp/"
rm -rf /tmp/*
sleep 0.2
ui_print "››CLEARING‹‹ /data/local/tmp/"
rm -rf /data/local/tmp/*
sleep 1
# --- Finalization ---
ui_print " "
ui_print "==== FINALIZING INSTALLATION ===="
sleep 0.2
ui_print "Please wait, this process is long, bg-dexopt-job operation in progress"
cmd package bg-dexopt-job
ui_print "Please wait, this process is very long, compile speed operation in progress"
cmd package compile -f -m speed -a

# --- Final ASCII Art ---
ui_print " "
ui_print "========================================"
ui_print "|                                      |"
ui_print "|        OPTIMIZATION COMPLETE!        |"
ui_print "|                                      |"
ui_print "========================================"
ui_print " "
ui_print "  [NOTE] No reboot required!"
ui_print "         Changes applied live"
ui_print " "
ui_print "----------------------------------------"
ui_print "  Telegram: @saltfor"
ui_print "  Thanks for using our module!"
ui_print "----------------------------------------"
ui_print " "

sleep 2