import 'package:flutter_app/presentation/app/cubits/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const routes = ['Chat', 'Webview'];

class AppCubit extends Cubit<AppState> {
  final bool isDarkMode;

  AppCubit({required this.isDarkMode})
    : super(
        AppState(
          navigationIndex: 0,
          pageTitle: routes[0],
          isDarkMode: isDarkMode,
        ),
      );

  void updateNavigationIndex({required int index}) {
    emit(
      NavigationState(
        navigationIndex: index,
        pageTitle: routes[index],
        isDarkMode: state.isDarkMode,
      ),
    );
  }

  void setIsDarkMode({required bool value}) {
    emit(
      ThemeBrightnessState(
        navigationIndex: state.navigationIndex,
        pageTitle: state.pageTitle,
        isDarkMode: value,
      ),
    );
  }
}
