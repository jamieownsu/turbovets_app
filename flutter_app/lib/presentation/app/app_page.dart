import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/bottom_navigation_widget.dart';
import 'package:flutter_app/presentation/app/cubits/app_cubit.dart';
import 'package:flutter_app/presentation/chat/chat_page.dart';
import 'package:flutter_app/presentation/webview/webview_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<AppCubit>().state.pageTitle),
        centerTitle: true,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.watch<AppCubit>().controller,
        children: const [ChatPage(), WebviewPage()],
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
