class AppState {
  final int navigationIndex;
  final String pageTitle;
  final bool isDarkMode;

  const AppState({
    required this.navigationIndex,
    required this.pageTitle,
    required this.isDarkMode,
  });
}

class InitialState extends AppState {
  InitialState({
    required super.navigationIndex,
    required super.pageTitle,
    required super.isDarkMode,
  });
}

class NavigationState extends AppState {
  NavigationState({
    required super.navigationIndex,
    required super.pageTitle,
    required super.isDarkMode,
  });
}

class ThemeBrightnessState extends AppState {
  ThemeBrightnessState({
    required super.navigationIndex,
    required super.pageTitle,
    required super.isDarkMode,
  });
}
