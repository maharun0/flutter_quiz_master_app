import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'controllers/app_controller.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';

class QuizMasterApp extends StatefulWidget {
  const QuizMasterApp({super.key, required this.controller});

  final AppController controller;

  @override
  State<QuizMasterApp> createState() => _QuizMasterAppState();
}

class _QuizMasterAppState extends State<QuizMasterApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              HomeScreen(controller: widget.controller),
        ),
        GoRoute(
          path: '/quiz/:categoryId',
          builder: (context, state) {
            final categoryId = state.pathParameters['categoryId'] ?? '';
            return QuizScreen(
              controller: widget.controller,
              categoryId: categoryId,
            );
          },
        ),
        GoRoute(
          path: '/result',
          builder: (context, state) =>
              ResultScreen(controller: widget.controller),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Quiz Master',
          debugShowCheckedModeBanner: false,
          themeMode: widget.controller.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1D4ED8),
            ),
            scaffoldBackgroundColor: const Color(0xFFF5F7FB),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF38BDF8),
              brightness: Brightness.dark,
            ),
          ),
          routerConfig: _router,
        );
      },
    );
  }
}
