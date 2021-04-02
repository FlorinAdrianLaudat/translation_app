import 'package:flutter/material.dart';

import 'core/db/hive_init.dart';
import 'core/injection_container.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  await HiveInit.init();

  runApp(MyApp());
}
