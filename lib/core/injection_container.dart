import 'package:get_it/get_it.dart';

import '../features/main_page/presentation/bloc/navigation_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerFactory(() => NavigationBloc());
}
