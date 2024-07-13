source $FUNCTION
import axeron.prop
w="[!]" #warn
i="[?]" #info
s="[\$]" #success
axeron="com.fhrz.axeron"
host="fahrez256.github.io"
host_path="/Laxeron/Core_2404.txt"
id_path="/Laxeron/Id_2404.txt"
log_path="/sdcard/Android/data/${axeron}/files"
log_file="${log_path}/log.txt"
this_core=$(dumpsys package ${axeron} | grep "signatures" | cut -d '[' -f 2 | cut -d ']' -f 1)
vCode=4100
vName="V4.2 ShellStorm"
vAxeron=10240121
androidId=$(settings get secure android_id)

[ -n "$1" ] && runPackage="$1"

axeron_core=$(cat <<-EOF
Optione {
  key:id="$id";
  key:name="$name";
  key:version="$version";
  key:versionCode=${versionCode};
  key:author="$author";
  key:description="$description";
  key:runPackage="$runPackage";
  key:install="$install";
  key:remove="$remove";
}
EOF
)

core_info=$(cat <<-EOF
Optione {
  key:versionCode=${vCode};
  key:versionAxeron=${vAxeron};
  key:androidId="$androidId";
  key:host="$host";
  key:hostPath="$host_path";
  key:idPath="$id_path";
  key:versionName="$vName";
  key:axeronSupport=${vAxeron};
}
EOF
)

join_channel() {
  sleep 1
  am start -a android.intent.action.VIEW -d "https://t.me/fahrezone_ch" > /dev/null 2>&1
}

c_exit() {
  rm -f "response" > /dev/null 2>&1
  exit 0
}

optimize_app() {
  for package in $(pkglist); do
    if ! whitelist | grep -q "$package" >/dev/null 2>&1 && [ ! "$runPackage" == "$package" ]; then
      cache_path="/sdcard/Android/data/${package}/cache"
      #[ -e "$cache_path" ] && rm -rf "$cache_path" > /dev/null 2>&1
      am stop-app "$package" > /dev/null 2>&1
    fi
  done
}

stop_google_app() {
  am set-standby-bucket com.google.android.gms never
  cmd appops set com.google.android.gms RUN_ANY_IN_BACKGROUND ignore
  cmd appops set com.google.android.gms RUN_IN_BACKGROUND ignore
  am force-stop com.google.android.gms/com.google.android.libraries.social.mediamonitor.MediaMonitor
  am force-stop com.google.android.gms/com.google.android.libraries.social.mediamonitor.MediaMonitorIntentService
  am force-stop com.google.android.gms/com.google.android.location.activity.HardwareArProviderService
  am force-stop com.google.android.gms/com.google.android.location.copresence.GcmRegistrationReceiver
  am force-stop com.google.android.gms/com.google.android.location.copresence.GservicesBroadcastReceiver
  am force-stop com.google.android.gms/com.google.android.location.fused.FusedLocationService
  am force-stop com.google.android.gms/com.google.android.location.fused.service.FusedProviderService
}

remove_thum() {
  rm -f /storage/emulated/0/Pictures/.thumbnails/*
  rm -f /storage/emulated/0/Movies/.thumbnails/*
}

if [ "$AXERON" ] && ! echo "$CORE" | grep -q "$this_core"; then
  echo "└$w You must use the original version of Axeron"
  join_channel
  c_exit
fi

if [ -z "$runPackage" ]; then
  echo "└$w PackageName is empty" && c_exit
elif ! echo "$PACKAGES" | grep -qw "$runPackage"; then
  echo "└[ $runPackage ] is not detected or installed" && c_exit
fi

if ! command -v am > /dev/null || ! command -v pm > /dev/null; then
  echo "└$w ActivityManager & PackageManager not Permitted" && c_exit
fi

if echo "$PACKAGES" | grep -qw "$axeron"; then
  echo "└$s LAxeron is detected [Fast Connect]" && sleep 1
else
  echo "├$w LAxeron not Installed"
  echo "└$i Please download LAxeron app from FahrezONE officially"
  join_channel
  c_exit
fi

mkdir -p "$log_path"
current_time=$(date +%s%3N)
last_time=$(cat "$log_file" 2>/dev/null)
time_diff=$((current_time - last_time))

if [ "$time_diff" -ge 2700000 ] || [ ! -e "$log_file" ]; then
  optimize_app
  stop_google_app
  remove_thum
  echo -n "$current_time" > "$log_file"
fi

am start -a android.intent.action.VIEW -n "com.fhrz.axeron/.Process" --es AXERON "$axeron_core" --es CORE "$core_info" > /dev/null 2>&1
c_exit
