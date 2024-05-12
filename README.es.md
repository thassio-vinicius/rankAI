[English](README.md) | Spanish


# RankAI

RankAI es una aplicación móvil desarrollada con Flutter y la API de OpenAI.

<p float="left">
  <img src="./previews/splash.png" width="250" />
  <img src="./previews/chat.png" width="250" /> 
  <img src="./previews/image_preview.png" width="250" />
</p>

## Instrucciones de Ejecución

Para ejecutar la aplicación:

1. Instala [Flutter](https://docs.flutter.dev/get-started/install)

2. Genera una clave de API secreta desde [OpenAI](https://openai.com/api/)

3. Copie la clave API generada y el ID de la organización (puede encontrar el ID de la organización [aquí](https://platform.openai.com/settings/organization/general)).

4. Cree un archivo .env en la carpeta raíz del proyecto y pegue sus claves en el formato siguiente (más información sobre el manejo de variables de entorno [aquí](https://pub.dev/packages/flutter_dotenv)):

```
API_KEY = TU_CLAVE_AQUÍ
API_ORGANIZATION = TU_ORGANIZACIÓN_ID_AQUÍ
```

5. Ejecuta `flutter gen-l10n` para generar los archivos `AppLocalizations`. ¡Actualmente ofrecemos soporte para los idiomas inglés y español!

6. Ejecuta la aplicación con `flutter run`. ¡Funciona tanto en Android como en iOS!

### Versión de Flutter

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
