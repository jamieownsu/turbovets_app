class AppState {
  final int navigationIndex;
  final String pageTitle;
  final bool isDarkMode;

  const AppState.initial({
    this.navigationIndex = 0,
    this.pageTitle = 'Chat',
    required this.isDarkMode,
  });

  const AppState.updateNavigation({
    required this.navigationIndex,
    required this.pageTitle,
    required this.isDarkMode,
  });

  const AppState.updateDarkMode({
    required this.navigationIndex,
    required this.pageTitle,
    required this.isDarkMode,
  });
}
