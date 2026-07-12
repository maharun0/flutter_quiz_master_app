import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/app_controller.dart';
import '../widgets/quiz_widgets.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final result = controller.lastResult;
    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Master')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Back to Home'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.categoryTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Final Score: ${result.correctAnswers}/${result.totalQuestions}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('Percentage: ${result.percentage}%'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ResultMetricRow(
              label: 'Total Questions',
              value: '${result.totalQuestions}',
            ),
            ResultMetricRow(
              label: 'Correct Answers',
              value: '${result.correctAnswers}',
            ),
            ResultMetricRow(
              label: 'Wrong Answers',
              value: '${result.wrongAnswers}',
            ),
            ResultMetricRow(label: 'Final Score', value: result.scoreText),
            ResultMetricRow(
              label: 'Percentage',
              value: '${result.percentage}%',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  await controller.playAgain();
                  final category = controller.activeCategory;
                  if (context.mounted && category != null) {
                    context.go('/quiz/${category.id}');
                  }
                },
                child: const Text('Play Again'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go('/'),
                child: const Text('Back To Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
