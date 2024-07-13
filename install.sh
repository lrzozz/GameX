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
esac

echo "$name | Free Version"
echo "Need More Booster? Donate \$1"
storm -x "$dcore" -fn "dcore" "$@"