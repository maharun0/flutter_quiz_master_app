import 'package:flutter/material.dart';

import 'app.dart';
import 'controllers/app_controller.dart';

export 'app.dart';
export 'controllers/app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = AppController();
  await controller.load();
  runApp(QuizMasterApp(controller: controller));
}
