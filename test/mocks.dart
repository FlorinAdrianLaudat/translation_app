import 'package:mockito/mockito.dart';
import 'package:translation_app/core/repository/repository.dart';
import 'package:translation_app/features/translate/data/datasource/translate_datasource.dart';
import 'package:translation_app/resources/network/network_constants.dart';

class MockRepository extends Mock implements Repository {}

class MockTranslateDataSource extends Mock implements TranslateDataSource {}

class MockNetworkConstants extends Mock implements NetworkConstants {}
