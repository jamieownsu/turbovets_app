import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/bottom_navigation_widget.dart';
import 'package:flutter_app/presentation/app/cubits/app_cubit.dart';
import 'package:flutter_app/presentation/app/cubits/app_state.dart';
import 'package:flutter_app/presentation/app/widgets/app_bar_widget.dart';
import 'package:flutter_app/presentation/chat/chat_page.dart';
import 'package:flutter_app/presentation/webview/webview_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state is NavigationState) {
            controller.animateToPage(
              state.navigationIndex,
              duration: Durations.medium4,
              curve: Curves.ease,
            );
          }
        },
        child: PageView(
          controller: controller,
          children: const [ChatPage(), WebviewPage()],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
