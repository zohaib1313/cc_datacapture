import 'package:cc_datacapture/my_application.dart';
import 'package:flutter/material.dart';

import 'app_utils/user_defaults.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDefaults.getPref();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorWidget(details.exception);
  };
  runApp(const MyApplication());
}
