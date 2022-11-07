import 'package:eztransport/app.dart';
import 'package:eztransport/core/enums/env.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  final log = CustomLogger(className: 'main');
  try {
    log.i('Testing info logs');
    log.d('Testing debug logs');
    log.e('Testing error logs');
    log.wtf('Testing WTF logs');
    WidgetsFlutterBinding.ensureInitialized();

    await setupLocator(Env.dev);
    runApp(const MyApp(title: 'Noca'));
  } catch (e, s) {
    log.d('$e');
    log.d('$s');
  }
}
