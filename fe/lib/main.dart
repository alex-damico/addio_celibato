import 'package:addio_celibato/injection.dart';
import 'package:addio_celibato/pages/home_page.dart';
import 'package:addio_celibato/pages/question_page.dart';
import 'package:addio_celibato/pages/complete_page.dart';
import 'package:addio_celibato/pages/questions_page.dart';
import 'package:addio_celibato/pages/hints_page.dart';
import 'package:addio_celibato/pages/create_hint_page.dart';
import 'package:addio_celibato/pages/task_page.dart';
import 'package:addio_celibato/pages/create_question_page.dart';
import 'package:addio_celibato/pages/create_task_page.dart';
import 'package:addio_celibato/utils/logger.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.setup();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addio Celibato',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/question': (context) => const QuestionPage(),
        '/complete': (context) => const CompletePage(),
        '/admin/questions': (context) => const QuestionsPage(),
        '/admin/hints': (context) => const HintsPage(),
        '/admin/tasks': (context) => const TaskPage(),
        '/admin/questions/create': (context) => const CreateQuestionPage(),
        '/admin/hints/create': (context) => const CreateHintPage(),
        '/admin/tasks/create': (context) => const CreateTaskPage(),
      },
    );
  }
}
