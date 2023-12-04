# Jukebox-Music-Player
Music player created in Flutter

## Code generation

```bash
$ make codegen
```

## Localization

```bash
$ code lib/src/common/localization/intl_en.arb
$ make intl
```

#### How to generate `keystore.jks`

Windows

```bash
keytool -genkey -v -keystore ~/android/keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 50000 -alias release
```

Mac

```bash
keytool -genkey -v -keystore ~/android/keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 50000 -alias release
```

#### How to get info from `keystore.jks`

Debug

```bash
keytool -list -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Release

```bash
keytool -list -v -keystore ./android/keystore.jks -alias release
```
