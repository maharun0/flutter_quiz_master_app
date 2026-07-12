import 'package:flutter_quiz_master_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('shows the dashboard', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final controller = AppController();
    await controller.load();

    await tester.pumpWidget(QuizMasterApp(controller: controller));
    await tester.pumpAndSettle();

    expect(find.text('Quiz Master'), findsWidgets);
    expect(
      find.text(
        'Welcome to Quiz Master! Test your knowledge and improve your learning skills.',
      ),
      findsOneWidget,
    );
    expect(find.text('Categories'), findsOneWidget);
  });
}
