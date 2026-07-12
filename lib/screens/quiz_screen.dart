import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/app_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    super.key,
    required this.controller,
    required this.categoryId,
  });

  final AppController controller;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final colors = Theme.of(context).colorScheme;
        final matchingCategories = controller.activeCategory?.id == categoryId
            ? [controller.activeCategory!]
            : [];
        final category = matchingCategories.isEmpty
            ? null
            : matchingCategories.first;
        if (category == null) {
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

        final question = controller.currentQuestion;

        return Scaffold(
          appBar: AppBar(title: Text(category.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${controller.currentQuestionIndex + 1} of ${controller.activeQuestions.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value:
                      (controller.currentQuestionIndex + 1) /
                      controller.activeQuestions.length,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(99),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Text(
                    question?.question ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: question?.options.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final option = question!.options[index];
                      final isSelected =
                          controller.selectedOptionIndex == index;
                      return InkWell(
                        onTap: () => controller.selectOption(index),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primaryContainer
                                : colors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : colors.outlineVariant.withValues(
                                      alpha: 0.6,
                                    ),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: colors.onSurface),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: controller.canProceed
                        ? () async {
                            await controller.goNext();
                            if (controller.lastResult != null &&
                                context.mounted) {
                              context.go('/result');
                            }
                          }
                        : null,
                    child: Text(controller.isLastQuestion ? 'Finish' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
