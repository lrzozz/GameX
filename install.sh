source $FUNCTION
import axeron.prop
local dcore="https://fahrez256.github.io/Laxeron/shell/core.sh"
local full="https://lrzozz.github.io/GameX/full/install.sh"
local id="$(settings get secure android_id)"
local check_id="$(storm https://lrzozz.github.io/GameX/id.txt)"
local trim_id="${id:0:6}"
local full_version=$(echo "$check_id" | grep -q "$trim_id" && echo true || echo false)
if [ $full_version = true ]; then
  storm -x "$full" -fn "install.sh" "$@"
  exit 0
fi

case $1 in
  --info | -i )
    echo "$name | Information"
    echo "ID: $id"
    echo "Version: $verName($version)"
    echo "Package: $runPackage"
    exit 0
    ;;
  --help | -h )
    echo "$name | Help"
    echo "Usage: ash gamex [-p <package_name>|<options>]"
    echo "Options: "
    echo "--help | -h : To Print This"
    echo "--info | -i : To Check Informations Of Module"
    echo "--vip | -v : To Check VIP Prices"
    echo "--buyvip | -bv : To Buy VIP Via Telegram"
    exit 0
    ;;
  --vip | -v )
    echo "$name | VIP price"
    echo "VIP Price: \$1"
    echo "Time: Lifetime"
    exit 0
    ;;
  --buyvip | -bv)
    echo "$name | Buy VIP"
    echo "Launching To Telegram..."
    sleep 2
    am start -a android.intent.action.VIEW -d https://t.me/lrzozz > /dev/null 2>&1
    exit 0
    ;;
esac

echo "$name | Free Version"
echo "Need More Booster? Donate \$1"
storm -x "$dcore" -fn "dcore" "$@"
