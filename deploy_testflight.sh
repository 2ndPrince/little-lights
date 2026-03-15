#!/bin/bash
# LittleLights — TestFlight upload script
# Requirements:
#   1. Apple ID (e.g. you@example.com)
#   2. App-specific password → generate at https://appleid.apple.com → Sign In → Security → App-Specific Passwords
#
# Usage:
#   chmod +x deploy_testflight.sh
#   ./deploy_testflight.sh

APPLE_ID="youngseoklee@gmail.com"       # ← update if different
IPA_PATH="build/ios/ipa/little_lights.ipa"

echo ""
echo "🚀 LittleLights — TestFlight Upload"
echo "──────────────────────────────────────"
echo "IPA: $IPA_PATH"
echo ""
echo "Enter your app-specific password (from appleid.apple.com → Security → App-Specific Passwords):"
read -s APP_SPECIFIC_PASSWORD
echo ""

echo "⏳  Validating IPA..."
xcrun altool --validate-app \
  --type ios \
  --file "$IPA_PATH" \
  --username "$APPLE_ID" \
  --password "$APP_SPECIFIC_PASSWORD" \
  --output-format xml

if [ $? -ne 0 ]; then
  echo "❌  Validation failed. Check your credentials or IPA."
  exit 1
fi

echo ""
echo "⏳  Uploading to TestFlight..."
xcrun altool --upload-app \
  --type ios \
  --file "$IPA_PATH" \
  --username "$APPLE_ID" \
  --password "$APP_SPECIFIC_PASSWORD" \
  --output-format xml

if [ $? -eq 0 ]; then
  echo ""
  echo "✅  Upload complete! Check App Store Connect → TestFlight in ~5–10 minutes."
  echo "    https://appstoreconnect.apple.com/apps/6760587236/testflight"
else
  echo "❌  Upload failed. See error above."
fi
