import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/app/cubits/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      title: Text(
        context.watch<AppCubit>().state.pageTitle,
        style: textTheme.headlineSmall!.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
      ),
      backgroundColor: colorScheme.primaryContainer,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            final sharedPrefs = await SharedPreferences.getInstance();
            if (context.mounted) {
              final isDarkMode = context.read<AppCubit>().state.isDarkMode;
              context.read<AppCubit>().setIsDarkMode(value: !isDarkMode);
              sharedPrefs.setBool("is_dark_mode", !isDarkMode);
            }
          },
          icon: Icon(
            context.watch<AppCubit>().state.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        ),
      ],
    );
  }
}
