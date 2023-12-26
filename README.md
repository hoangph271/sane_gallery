![sane_gallery logo](android/app/src/main/res/drawable-mdpi/android12splash.png)

# sane_gallery

Sane**Gallery** is the Flutter reimplementation of [gallereasy](https://github.com/hoangph271/gallereasy), a web app for searching & saving GIFs.

## Deployed Web Version

Check out the live version of Sane Gallery on the web: [SaneGallery Web](https://sane-gallery.netlify.app/)

## Android Build

If you prefer to use Sane Gallery on your Android device, you can download the APK files for the latest release:

- [Download APK for ARM64-v8a](https://github.com/hoangph271/sane_gallery/releases/download/v0.0.2-alpha/app-arm64-v8a-release.apk)
- [Download APK for ARM-v7a](https://github.com/hoangph271/sane_gallery/releases/download/v0.0.2-alpha/app-armeabi-v7a-release.apk)
- [Download APK for x86_64](https://github.com/hoangph271/sane_gallery/releases/download/v0.0.2-alpha/app-x86_64-release.apk)

To install the APK on your Android device:

1. Download the appropriate APK file from the provided link.
2. Open the file on your Android device.
3. Follow the on-screen instructions to install the app.

Note: Make sure to enable "Install from unknown sources" in your device settings if you haven't already.

Additionally, you can verify the integrity of the downloaded APK files by checking their SHA1 hash values:

- [SHA1 for ARM64-v8a APK](https://github.com/hoangph271/sane_gallery/releases/download/v0.0.2-alpha/app-arm64-v8a-release.apk.sha1)
- [SHA1 for ARM-v7a APK](https://github.com/hoangph271/sane_gallery/releases/download/v0.0.2-alpha/app-armeabi-v7a-release.apk.sha1)
- [SHA1 for x86_64 APK](https://github.com/hoangph271/sane_gallery/releases/download/v0.0.2-alpha/app-x86_64-release.apk.sha1)

## Getting Started
To get started with Sane**Gallery**, follow these steps:

```bash
# Clone the repository:
git clone https://github.com/hoangph271/sane_gallery.git

# Navigate to the project directory:
cd sane_gallery

# Install dependencies:
flutter pub get

# Run the app:
flutter run
```

## TODO List:

- [ ] no more results banner
- [ ] Remove favorites from view when unfavorited
- [x] splash screen
- [x] [Failed to load favorites](https://github.com/hoangph271/sane_gallery/issues/5)
- [x] Infinite scroll
- [x] Deploy the web app
- [x] Automate the Android build process

## License

This project is licensed under the DBAD License - see the [LICENSE](LICENSE) file for details.
