class AppState {
  final int navigationIndex;
  final String pageTitle;

  const AppState.initial({this.navigationIndex = 0, this.pageTitle = 'Chat'});

  const AppState.updateNavigation({
    required this.navigationIndex,
    required this.pageTitle,
  });
}
