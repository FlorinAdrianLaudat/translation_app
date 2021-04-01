import 'package:flutter/material.dart';

import 'core/injection_container.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(MyApp());
}
