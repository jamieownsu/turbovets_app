import 'package:flutter/material.dart';
import 'package:flutter_app/data/datasource/chat_datasource.dart';
import 'package:flutter_app/data/repository/chat_repository_impl.dart';
import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/domain/usecase/get_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/load_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/send_message_usecase.dart';
import 'package:flutter_app/presentation/app/app_page.dart';
import 'package:flutter_app/presentation/app/cubits/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(MessageOriginTypeAdapter());
  final sharedPrefs = await SharedPreferences.getInstance();
  final isDarkMode = sharedPrefs.getBool("is_dark_mode") ?? false;
  final chatBox = await Hive.openBox<ChatMessage>('chatMessages');
  runApp(
    BlocProvider<AppCubit>(
      create: (context) => AppCubit(isDarkMode: isDarkMode),
      child: MyApp(chatBox: chatBox),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Box<ChatMessage> chatBox;

  const MyApp({super.key, required this.chatBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurboVets App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: context.watch<AppCubit>().state.isDarkMode
              ? Brightness.dark
              : Brightness.light,
        ),
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ChatDatasourceImpl()),
          RepositoryProvider(
            create: (context) => ChatRepositoryImpl(
              datasource: context.read<ChatDatasourceImpl>(),
              chatBox: chatBox,
            ),
            dispose: (value) => chatBox.close(),
          ),
          RepositoryProvider(
            create: (context) => LoadMessagesUseCase(
              chatRepository: context.read<ChatRepositoryImpl>(),
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
        child: AppPage(),
      ),
    );
  }
}
