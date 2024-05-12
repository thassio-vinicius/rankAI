# RankAI

RankAI es una aplicación móvil desarrollada con Flutter y la API de OpenAI.

<img  width="250" src="./previews/splash.png"   ><img  width="250" src="./previews/chat.png" hspace="50"><img  width="250" src="./previews/image_preview.png" >

## Instrucciones de Ejecución

Para ejecutar la aplicación:

1. Instala [Flutter](https://docs.flutter.dev/get-started/install)

2. Genera una clave de API secreta desde [OpenAI](https://openai.com/api/)

3. Copia la clave de API generada, crea un archivo `.env` en la carpeta raíz del proyecto y pega la clave en el formato siguiente (más información sobre el manejo de variables de entorno [aquí](https://pub.dev/packages/flutter_dotenv)):

```
API_KEY = TU_CLAVE_AQUÍ
```

4. Ejecuta `flutter gen-l10n` para generar los archivos `AppLocalizations`. ¡Actualmente ofrecemos soporte para los idiomas inglés y español!

5. Ejecuta la aplicación con `flutter run`. ¡Funciona tanto en Android como en iOS!

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