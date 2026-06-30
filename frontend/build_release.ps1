Write-Host "=========================================="
Write-Host "   Building StartupConnect for Production "
Write-Host "=========================================="

Write-Host "Cleaning workspace..."
flutter clean
flutter pub get

Write-Host "Building Web Production Bundle..."
# We use canvaskit for desktop-class rendering on the web
flutter build web --release --web-renderer canvaskit --dart-define=ENV=production

Write-Host "Building Android App Bundle (AAB)..."
# Obfuscate code and strip debug info
flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols --dart-define=ENV=production

Write-Host "Build complete! Web bundle is in build/web. AAB is in build/app/outputs/bundle/release"
Write-Host "To deploy to firebase run: firebase deploy --only hosting"
