import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/app/cubits/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const routes = ['Chat', 'Webview'];

class AppCubit extends Cubit<AppState> {
  final PageController controller = PageController();

  AppCubit() : super(const AppState.initial());

  void updateNavigationIndex(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
    emit(
      AppState.updateNavigation(
        navigationIndex: index,
        pageTitle: routes[index],
      ),
    );
  }
}
