import 'package:eztransport/app.dart';
import 'package:flutter/material.dart';
import 'core/enums/env.dart';
import 'core/others/logger_customizations/custom_logger.dart';
import 'locator.dart';

Future<void> main() async {
  final log = CustomLogger(className: 'main');
  try {
    log.i('Testing info logs');
    log.d('Testing debug logs');
    log.e('Testing error logs');
    log.wtf('Testing WTF logs');
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator(Env.test);
    runApp(const MyApp(title: 'Test - App Name'));
  } catch (e, s) {
    log.d('$e');
    log.d('$s');
  }
}