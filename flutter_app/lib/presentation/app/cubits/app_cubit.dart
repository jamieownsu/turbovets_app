import 'package:flutter_app/presentation/app/cubits/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const routes = ['Chat', 'Webview'];

class AppCubit extends Cubit<AppState> {
  final bool isDarkMode;

  AppCubit({required this.isDarkMode})
    : super(AppState.initial(isDarkMode: isDarkMode));

  void updateNavigationIndex(int index) {
    emit(
      AppState.updateNavigation(
        navigationIndex: index,
        pageTitle: routes[index],
        isDarkMode: state.isDarkMode,
      ),
    );
  }

  void setIsDarkMode({required bool value}) {
    emit(
      AppState.updateDarkMode(
        navigationIndex: state.navigationIndex,
        pageTitle: state.pageTitle,
        isDarkMode: value,
      ),
    );
  }
}
