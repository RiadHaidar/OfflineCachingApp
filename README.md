# PR Awareness

A Flutter application built with Clean Architecture principles, featuring dynamic theming with persistence and modern state management.

## Architecture

This project follows **Clean Architecture** with a **feature-based** structure, ensuring separation of concerns and scalability.

### Architecture Layers

```
lib/
├── core/                    # Shared resources across features
│   ├── di/                  # Dependency Injection (GetIt)
│   ├── helpers/             # Helper classes and constants
│   ├── networking/          # API client setup (Dio, Retrofit)
│   ├── routing/             # Navigation (GoRouter)
│   └── theming/             # Theme configuration
│
├── features/                # Feature modules
│   └── movies/
│       ├── data/            # Data Layer
│       │   ├── apis/        # API services
│       │   ├── models/      # Data models
│       │   └── repos/       # Repository implementations
│       │
│       └── presentation/    # Presentation Layer
│           ├── screens/     # UI screens
│           └── widgets/     # Reusable widgets
│
├── main.dart               # App entry point
└── prawareness_app.dart    # Root app widget
```

### Architecture Principles

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Feature-based Structure**: Code organized by features for better scalability
3. **Dependency Injection**: Using `get_it` for loose coupling
4. **State Management**: BLoC pattern with `flutter_bloc`
5. **Code Generation**: Leveraging `build_runner` for boilerplate reduction

## Theming System

### Overview

The app uses **theme_tailor** for custom theme management, providing a type-safe, consistent theming approach across the entire application.

### Key Features

- **Type-safe Theme Properties**: All theme values are strongly typed
- **Theme Persistence**: Theme preference persists across app sessions using HydratedBloc
- **Automatic Code Generation**: Theme extensions are auto-generated
- **Easy Theme Switching**: Toggle between light and dark themes seamlessly

### Theme Architecture

#### 1. Theme Definition (`lib/core/theming/my_theme.dart`)

```dart
@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme> with _$MyThemeTailorMixin {
  const MyTheme({
    required this.background,
    required this.surface,
    required this.primary,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.headlineStyle,
    required this.bodyStyle,
    required this.captionStyle,
    required this.buttonStyle,
    required this.cardBorderRadius,
    required this.cardElevation,
    required this.spacing,
    required this.containerPadding,
  });

  // Colors
  final Color background;
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;

  // Typography
  final TextStyle headlineStyle;
  final TextStyle bodyStyle;
  final TextStyle captionStyle;
  final TextStyle buttonStyle;

  // Shapes & Dimensions
  final BorderRadius cardBorderRadius;
  final double cardElevation;
  final double spacing;
  final EdgeInsets containerPadding;
}
```

#### 2. Theme Instances

Two theme instances are defined:

**Light Theme:**
```dart
final lightAppTheme = MyTheme(
  background: Colors.white,
  surface: Colors.white,
  primary: Colors.blue,
  textPrimary: Colors.black,
  headlineStyle: TextStyles.font24BlackBold,
  // ... other properties
);
```

**Dark Theme:**
```dart
final darkAppTheme = MyTheme(
  background: Colors.black,
  surface: Colors.black,
  primary: Colors.blue,
  textPrimary: Colors.white,
  headlineStyle: TextStyles.font24WhiteBold,
  // ... other properties
);
```

#### 3. Theme State Management (`lib/core/theming/theme_cubit.dart`)

Using **HydratedCubit** for automatic theme persistence:

```dart
class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  bool get isDarkMode => state == ThemeMode.dark;

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final isDark = json['isDark'] as bool? ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'isDark': state == ThemeMode.dark};
  }
}
```

**Key Points:**
- Extends `HydratedCubit<ThemeMode>` instead of regular `Cubit`
- Automatically persists theme preference to local storage
- Restores theme on app restart
- Simple JSON serialization with `fromJson` and `toJson`

#### 4. App Integration (`lib/prawareness_app.dart`)

```dart
class PrawarenessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          theme: ThemeData(
            brightness: Brightness.light,
            extensions: [lightAppTheme],
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            extensions: [darkAppTheme],
          ),
          themeMode: themeMode,  // Controlled by ThemeCubit
          routerConfig: AppRouter.createRouter(context.read<ThemeCubit>()),
        );
      },
    );
  }
}
```

**How it works:**
- `BlocBuilder` listens to `ThemeCubit` state changes
- `theme` parameter receives light theme with `lightAppTheme` extension
- `darkTheme` parameter receives dark theme with `darkAppTheme` extension
- `themeMode` determines which theme to use
- MaterialApp automatically switches themes based on `themeMode`

### Using Themes in Widgets

#### Method 1: Using the Generated Extension (Recommended)

```dart
Widget build(BuildContext context) {
  final theme = Theme.of(context).extension<MyTheme>()!;

  return Container(
    color: theme.background,
    padding: theme.containerPadding,
    child: Text(
      'Hello World',
      style: theme.headlineStyle,
    ),
  );
}
```

#### Method 2: Using Context Extension (Direct Access)

```dart
Widget build(BuildContext context) {
  return Container(
    color: context.background,  // Direct property access
    child: Text(
      'Hello World',
      style: context.headlineStyle,
    ),
  );
}
```

#### Switching Themes

```dart
// Toggle theme
context.read<ThemeCubit>().toggleTheme();

// Check current theme
final isDark = context.read<ThemeCubit>().isDarkMode;
```

### Generating Theme Code

After modifying `my_theme.dart`, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates `my_theme.tailor.dart` with:
- `copyWith()` method
- `lerp()` method for smooth theme transitions
- Extension methods on `BuildContext` for easy access
- Equality operators (`==` and `hashCode`)

## State Management

### BLoC Pattern with HydratedBloc

**Why HydratedBloc?**
- Automatic state persistence to local storage
- Restore state after app restart
- Simple JSON serialization
- Built on top of `flutter_bloc`

**Setup (in `main.dart`):**

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await setupGetIt();

  runApp(
    BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: const PrawarenessApp(),
    ),
  );
}
```

**Key Components:**
1. **HydratedStorage**: Manages local storage for state persistence
2. **BlocProvider**: Provides cubit instance to widget tree
3. **Dependency Injection**: Using GetIt for cubit registration

## Tech Stack

### Core Dependencies

- **flutter_bloc** (^8.1.6): State management with BLoC pattern
- **hydrated_bloc** (^9.1.5): State persistence
- **get_it** (^7.7.0): Dependency injection
- **go_router** (^14.2.0): Declarative routing
- **theme_tailor_annotation** (^3.1.1): Theme code generation
- **path_provider** (^2.1.5): Access to device file system

### Networking

- **dio** (^5.5.0+1): HTTP client
- **retrofit** (^4.1.0): Type-safe REST client

### Code Generation

- **build_runner** (^2.4.13): Build system
- **theme_tailor** (^3.0.1): Theme code generator
- **retrofit_generator** (^8.1.2): REST client generator
- **json_serializable** (^6.8.0): JSON serialization
- **freezed** (^2.5.2): Data class generation

## Getting Started

### Prerequisites

- Flutter SDK: ^3.9.2
- Dart SDK: ^3.9.2

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd prawareness
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Development Workflow

#### Adding a New Theme Property

1. Add the property to `MyTheme` class in `my_theme.dart`
   ```dart
   final Color accentColor;
   ```

2. Add to both theme instances
   ```dart
   final lightAppTheme = MyTheme(
     accentColor: Colors.orange,
     // ...
   );
   ```

3. Regenerate theme code
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Use in widgets
   ```dart
   Container(color: context.accentColor)
   ```

#### Creating a New Feature

1. Create feature folder structure:
   ```
   lib/features/your_feature/
   ├── data/
   │   ├── apis/
   │   ├── models/
   │   └── repos/
   └── presentation/
       ├── screens/
       └── widgets/
   ```

2. Follow the existing pattern in the `movies` feature
3. Register dependencies in `dependency_injection.dart`
4. Add routes in `app_router.dart`

## Project Structure Details

### Core Module

- **DI (Dependency Injection)**: Centralized service registration using GetIt
- **Helpers**: Constants, utilities, and helper functions
- **Networking**: API client configuration, error handling
- **Routing**: App-wide navigation configuration
- **Theming**: Theme definitions and state management

### Feature Module (Movies Example)

```
features/movies/
├── data/
│   ├── apis/              # API endpoints (Retrofit)
│   ├── models/            # Data models (JSON serializable)
│   └── repos/             # Repository implementations
└── presentation/
    ├── screens/           # Full-page screens
    └── widgets/           # Reusable UI components
```

## Best Practices

### Theme Usage

✅ **DO:**
- Use `theme.property` for all colors, styles, and dimensions
- Use theme spacing for consistent layout: `theme.spacing`, `theme.spacing * 2`
- Access theme early in build method: `final theme = Theme.of(context).extension<MyTheme>()!;`

❌ **DON'T:**
- Hardcode colors: `Colors.white`, `Color(0xFF123456)`
- Hardcode text styles: `TextStyle(fontSize: 16, color: Colors.black)`
- Hardcode spacing: `EdgeInsets.all(16)`, `SizedBox(height: 20)`

### State Management

✅ **DO:**
- Use HydratedCubit for state that needs persistence
- Implement `fromJson` and `toJson` for serialization
- Keep cubit logic simple and focused

❌ **DON'T:**
- Store complex objects that can't be serialized
- Put business logic in widgets
- Create multiple cubits for simple state

### Code Generation

✅ **DO:**
- Run build_runner after modifying generated code sources
- Use `--delete-conflicting-outputs` flag to avoid conflicts
- Commit generated files to version control

❌ **DON'T:**
- Manually edit generated files (`.g.dart`, `.freezed.dart`, `.tailor.dart`)
- Skip running build_runner after changes

## Contributing

When contributing to this project:

1. Follow the existing architecture and folder structure
2. Use the theme system for all UI properties
3. Write descriptive commit messages
4. Run `flutter analyze` before committing
5. Ensure all generated code is up to date

## License

This project is licensed under the MIT License.
