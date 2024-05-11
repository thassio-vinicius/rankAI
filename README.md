# RankAI

RankAI Mobile app developed with Flutter and the OpenAI API.

### Flutter Version

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.19.6, on macOS 14.4.1 23E224 darwin-arm64, locale en-GB)
[✓] Android toolchain - develop for Android devices (Android SDK version 32.0.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 15.3)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.2)
[✓] VS Code (version 1.88.0)
[✓] Connected device (5 available)            
[✓] Network resources
```

## Run Instructions

To run the app:

1. Install [Flutter](https://docs.flutter.dev/get-started/install)

2. Generate a secret API Key from [OpenAI](https://openai.com/api/):

3. Copy the generated API Key, create a `.env` file in the project's root folder and paste the key in the format below (more info on handling environment variables [here](https://pub.dev/packages/flutter_dotenv)):

```
API_KEY = YOUR_KEY_HERE
```

4. Run `flutter gen-l10n` to generate the `AppLocalizations` files. We currently support English and Spanish languages!

5. Run the app with `flutter run`. It works on both Android and iOS!
