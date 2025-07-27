import 'package:flutter/material.dart';
import 'package:flutter_app/data/datasource/chat_datasource.dart';
import 'package:flutter_app/data/repository/chat_repository_impl.dart';
import 'package:flutter_app/domain/usecase/get_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/send_message_usecase.dart';
import 'package:flutter_app/presentation/app/app_page.dart';
import 'package:flutter_app/presentation/app/cubits/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurboVets App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ChatDatasourceImpl()),
          RepositoryProvider(
            create: (context) => ChatRepositoryImpl(
              datasource: context.read<ChatDatasourceImpl>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => SendMessageUseCase(
              chatRepository: context.read<ChatRepositoryImpl>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => GetMessageUseCase(
              chatRepository: context.read<ChatRepositoryImpl>(),
            ),
          ),
        ],
        child: BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
          child: AppPage(),
        ),
      ),
    );
  }
}
