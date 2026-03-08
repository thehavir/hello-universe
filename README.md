# Hello Universe!

A Flutter app that displays NASA's Astronomy Picture of the Day (APOD) using the NASA API.

## Technical Overview

**Architecture**: Clean Architecture.  
**State Management**: BLoC pattern using Cubit with custom sealed state classes.

## Project Structure

```
lib/src/
├── data/                          # Data layer (APIs, repositories)
│
├── domain/                        # Business logic (entities, use cases)
│
├── presentation/                  # UI layer (screens, cubits, widgets)
│   ├── apods_list/                # APODs list screen feature
│   ├── apod_details/              # APOD details screen feature
│   ├── apod_full_size/            # APOD full-size viewer feature
│
├── utils/                         # Shared utilities (DI, navigation, extensions)
│
test/src/                          # Unit and widget tests
```

## Getting Started

### Prerequisite
Flutter 3.38.7+ / Dart 3.10+

### Run/Test

```bash
# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Run app
flutter run
```
