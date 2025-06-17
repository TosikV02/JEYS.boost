#!/system/bin/sh

wait_until_login() {
    while [[ "$(getprop sys.boot_completed)" != "1" ]]; do
        sleep 1
    done
    
}

wait_until_login

#Cleaning
pm trim-caches 99999G
rm -rf /data/data/*/cache/*
rm -rf /sdcard/Android/data/*/cache/*
rm -rf /sdcard/Android/obb/*/cache/*
find /storage/emulated/0 -type d -empty -delete
rm -rf /cache/*
rm -rf /tmp/*
rm -rf /data/local/tmp/*

su -lp 2000 -c "cmd notification post -S bigtext -t 'JEYS.boost' 'Tag' '[/] Clearing cache has been completed! ⚡'"