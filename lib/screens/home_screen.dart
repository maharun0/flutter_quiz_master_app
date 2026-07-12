import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/app_controller.dart';
import '../models/quiz_models.dart';
import '../widgets/quiz_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Master'),
        actions: [
          IconButton(
            onPressed: controller.toggleTheme,
            icon: Icon(
              controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF0B1220), const Color(0xFF111827)]
                : [const Color(0xFFF5F7FB), const Color(0xFFE8EEF9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderCard(isDarkMode: controller.isDarkMode),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Statistics'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.45,
                children: [
                  StatCard(
                    title: 'Total Quiz Attempts',
                    value: '${controller.totalAttempts}',
                  ),
                  StatCard(
                    title: 'Highest Score',
                    value: controller.highestScore.display,
                  ),
                  StatCard(
                    title: 'Last Score',
                    value: controller.lastScore.display,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Categories'),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quizCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.08,
                ),
                itemBuilder: (context, index) {
                  final category = quizCategories[index];
                  return CategoryCard(
                    category: category,
                    onTap: () {
                      controller.startQuiz(category);
                      context.go('/quiz/${category.id}');
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'History'),
              const SizedBox(height: 12),
              if (controller.history.isEmpty)
                const EmptyHistory()
              else
                Column(
                  children: controller.history
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: HistoryTile(item: item),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
