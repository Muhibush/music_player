# Music Player

A music player app that allows you to search for music by artist. Music source from [iTunes affiliate API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api). Made using [Flutter](https://flutter.dev/) with simple [clean architecture inspired by Reso Coder](https://resocoder.com/flutter-clean-architecture-tdd/) and [Bloc state management by Felix Angelov](https://bloclibrary.dev/#/gettingstarted). Design Inspired by Spotify.

Search songs by artist      | Play and pause song 
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/24708307/145715702-34f8819d-9df9-421a-babb-95e5aee6466b.png" width="300">  |  <img src="https://user-images.githubusercontent.com/24708307/145715708-dd8813fd-12b0-4bb8-9d27-5652d800deac.png" width="300">

Intial screen              |  Empty result             |  Connection error
:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/24708307/145715645-7f3eccf5-b35a-434c-91f6-1a3699243445.png" width="300"> |  <img src=https://user-images.githubusercontent.com/24708307/145715711-f954ef82-abfd-4cf8-bff4-9e9b508a194b.png width="300">  | <img src=https://user-images.githubusercontent.com/24708307/145715718-23bc0435-a471-4218-bde0-423647115121.png width="300">

## Supported features
- Search song preview by the artist
- Play and stop a song
- Playing indicator
- Play song in the background
- Portrait lock
- Error handling includes empty results, server errors, and connection errors.

## Supported devices
- You can run this app on Android API level 16 (Jelly Bean) or above.

## In this project, I try to implement some stacks like
- Implement Clean architecture that inspired by [reso coder](https://resocoder.com/flutter-clean-architecture-tdd/)
- Bloc state management using [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- implement simple [atomic design](https://bradfrost.com/blog/post/atomic-web-design/)
- Service Locator using [get_it](https://pub.dev/packages/get_it)
- unit test using a build-in test kit from flutter and [bloc test](https://pub.dev/packages/bloc_test)
- mocking using [mocktail](https://pub.dev/packages/mocktail)
- state logging using [bloc observer](https://bradfrost.com/blog/post/atomic-web-design/)
- handle debounce event.

## Prerequisites
- Before you begin, ensure you have installed [flutter based on your operating system](https://docs.flutter.dev/get-started/install)
- Android device or Android emulator with Android API level 16 (Jelly Bean) or above.

## How to build
- Ensure you have flutter installed
- Clone this repository `git clone https://github.com/Muhibush/music_player.git`
- Open projects on your IDE like Android Studio, Visual Code, etc..
- Open android simulator or connect your android device
- Run `flutter pub get` to get all dependencies that are needed
- Use command `flutter run` to build in debug mode or use `flutter run --release` to build release mode.

## How to run unit test
- Run `flutter test` inside the project directory
- Generate coverage report using `flutter test --coverage`, a coverage report seems to be generated into a file `/coverage/lcov.info`.

## Contact
If you want to contact me you can reach me at [Instagram](https://www.instagram.com/muhibush/) or [Linkedin](https://www.linkedin.com/in/muhibush/).
