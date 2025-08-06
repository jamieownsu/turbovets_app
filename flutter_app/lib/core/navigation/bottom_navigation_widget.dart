import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/app/cubits/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Webview'),
      ],
      currentIndex: context.watch<AppCubit>().state.navigationIndex,
      onTap: (i) {
        context.read<AppCubit>().updateNavigationIndex(index: i);
      },
    );
  }
}
