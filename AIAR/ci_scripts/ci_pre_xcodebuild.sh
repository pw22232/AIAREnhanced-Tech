#!/bin/sh

# THIS SCRIPT IS FOR CI WORKFLOWS ON XCODE CLOUD ONLY
# DO NOT RUN IN LOCAL ENVIRONMENT

# convert YES or NO to <true></true> or <false></false>
convert() {
	case $1 in
	YES)
		echo "<true></true>"
		;;
	NO)
		echo "<false></false>"
		;;
	*)
		echo "Error: Invalid value '$1'. Must be 'YES' or 'NO'." >&2
		exit 1
		;;
	esac
}

# Path to where GoogleService-Info.plist should be
PLIST_FILEPATH="../AIAR/GoogleService-Info.plist"

# Check if GoogleService-Info.plist already exists
# If it exists, do not overwrite it
# This is a safeguard to protect against running in a local environment where the environment variables haven't been set
if [ -e "$PLIST_FILEPATH" ]; then
	echo "Warning: File '$PLIST_FILEPATH' already exists. Skipping creation." >&2
	exit 0
fi

# Create and populate GoogleService-Info.plist
cat <<EOF >"$PLIST_FILEPATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>API_KEY</key>
<string>$API_KEY</string>
<key>GCM_SENDER_ID</key>
<string>$GCM_SENDER_ID</string>
<key>PLIST_VERSION</key>
<string>$PLIST_VERSION</string>
<key>BUNDLE_ID</key>
<string>$BUNDLE_ID</string>
<key>PROJECT_ID</key>
<string>$PROJECT_ID</string>
<key>STORAGE_BUCKET</key>
<string>$STORAGE_BUCKET</string>
<key>IS_ADS_ENABLED</key>
$(convert "$IS_ADS_ENABLED")
<key>IS_ANALYTICS_ENABLED</key>
$(convert "$IS_ANALYTICS_ENABLED")
<key>IS_APPINVITE_ENABLED</key>
$(convert "$IS_APPINVITE_ENABLED")
<key>IS_GCM_ENABLED</key>
$(convert "$IS_GCM_ENABLED")
<key>IS_SIGNIN_ENABLED</key>
$(convert "$IS_SIGNIN_ENABLED")
<key>GOOGLE_APP_ID</key>
<string>$GOOGLE_APP_ID</string>
</dict>
</plist>
EOF
