source $FUNCTION
import axeron.prop
local verName="V1.0-stable-online"
local version=10
local p="[ ➤ ]"
local fc="https://lrzozz.github.io/GameX/core.sh"
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
    echo "$p Version: $verName($version)"
    echo "$p Package: ${runPackage:-null}"
    exit 0
    ;;
esac

echo "$name | Full Version [$verName($id)]"
echo "$p Thanks For Buy Full Version, Enjoy Increase Performance 40%"
storm -x "$fc" -fn "fc" "$@"