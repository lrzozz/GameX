source $FUNCTION
source $(dirname $0)/axeron.prop
import axeron.prop
local p="[ ➤ ]"
local fc="https://lrzozz.github.io/GameX/full/core.sh"
local id="$(settings get secure android_id)"
local trim_id="${id:0:6}"

case $1 in
  --info | -i )
    log_path="/sdcard/Android/data/${AXERONPKG}/files"
    log_file="${log_path}/log.txt"
    current_time=$(date +%s%3N)
    last_time=$(cat "$log_file" 2>/dev/null)
    time_diff=$((2700000 - (current_time - last_time)))
    echo "$name | Information"
    echo "$p User ID: $id($trim_id)"
    echo "$p Version: $version($versionCode)"
    echo "$p Package: ${runPackage:-null}"
    exit 0
    ;;
  --help | -h )
    echo "$name | Help"
    echo "Usage: ash gamex [-p <package_name>|<options>]"
    echo "Options: "
    echo "--help | -h : To Print This"
    echo "--info | -i : To Check Informations Of Module"
    exit 0
    ;;
  --x-mode | -x )
    echo "$name | Enable X-Mode"
    echo "Starting X Mode..."
    sleep 2
    cmd package reconcile-secondary-dex-files "$runPackage"
    for app in $(cmd package list packages -3 | cut -f 2 -d ":"); do
    if [[ ! "$app" == "com.fhrz.axeron" ]]; then
    cmd activity force-stop "$app"
    cmd activity kill "$app"
    fi
    done
    sleep 2
    echo "X Mode Has Started, Now Waiting To Enter LAxeron"
    storm -x "$fc" -fn "fc" "$@"
    exit 0
    ;;
esac

if [ -z $runPackage ]; then
  echo "Harap Masukkan Package!"
fi

echo "$name | Full Version"
echo "$p Thanks For Buy Full Version, Enjoy Increase Performance 40%"
storm -x "$fc" -fn "fc" "$@"
