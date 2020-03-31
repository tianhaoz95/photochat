# Mini Donkey

Mini Donkey is a app to protect privacy on social media with encrypted steganography.

## Prerequisite

* Install Flutter SDK. Please follow the [instructions](https://flutter.dev/docs/get-started/install).
* Install Flutter edior plugin. Please follow the [instructions](https://flutter.dev/docs/get-started/editor).
* Install package dependencies with `flutter pub get`

## Getting Started

To get the code:

```bash
git clone https://github.com/tianhaoz95/photochat.git
```

To start the app:

1. Start an Android/iOS emulator, check with `flutter devices`
2. Use `flutter run`

note: to run debug build on Android, do `export ANDROID_DEBUG=true` before `flutter run`. Otherwise, it will fail due to missing Android code signing credentials.

To run unit tests: `flutter test`

To run integration tests: `flutter drive test_driver/app.dart`

## Structure

* `lib` contains all the source code, and developers should work in this directory most of the time.
* `test` contains unit tests and widget tests.
* `test_driver` contains the integration tests.
* `android` contains the Android specific project setup.
* `ios` contains the iOS specific project setup.
* `macos` contains the MacOS specific project setup.
* `web` contains the Web specific project setup.
* `assets` contains the data including images and animations.

## Documentation

Mini Donkey uses `dartdoc` to generate documentation.

To edit `dartdoc` configuration, see `dartdoc_options.yaml` and the official `dartdoc` [docs](https://github.com/dart-lang/dartdoc).

The overall design is documented in `README.md` and the implementation details are documented in the source code and developers should also follow this guideline.

### Generate docs

To generate docs locally, run `dartdoc` in the root Flutter project directory.

> Note: the generated docs are ignored by verson control on purpose because it will be automatically generated per push to `master` branch, please don't ever check the generated docs into version control.

## Dependencies

The dependencies are tracked in `pubspec.yaml` as Flutter convention.

### Upgrade a dependency

To upgrade a dependency, change the exact version number in `pubspec.yaml` and then run `flutter pub get` to install the upgraded version.

To upgrade all dependencies, use `flutter pub upgrade`. Note that, as some Flutter package has not yet reach a stable state, doing so can result in crashes.

## Automation

### Heimdall

Heimdall runs linter checks, unit tests and widget tests for every push regardless of branch. For details please see the [workflow configuration](https://github.com/tianhaoz95/photochat/blob/master/.github/workflows/heimdall.yml).

### Thor

Thor runs integration tests on all devices for every pull request to the `master` branch. For details please see the [workflow configuration](https://github.com/tianhaoz95/photochat/blob/master/.github/workflows/thor.yml).

### Loki

Loki runs the releasing process for every push to the `master` branch and every `release`. For details please see the [workflow configuration](https://github.com/tianhaoz95/photochat/blob/master/.github/workflows/loki.yml).
