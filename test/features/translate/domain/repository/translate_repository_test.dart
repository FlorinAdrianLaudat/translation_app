import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:translation_app/core/usecase/usecase.dart';
import 'package:translation_app/features/translate/data/repository/translate_repository_impl.dart';
import 'package:translation_app/features/translate/domain/usecase/translate_params.dart';

import '../../../../mocks.dart';
import '../../../../stubs.dart';

main() {
  late MockRepository mockRepository;
  late MockTranslateDataSource dataSource;
  late TranslateRepositoryImpl repository;

  setUp(() {
    mockRepository = MockRepository();
    dataSource = MockTranslateDataSource();
    repository = TranslateRepositoryImpl(
      dataSource: dataSource,
      repository: mockRepository,
    );
  });

  test('should success when getLanguageList is called', () async* {
    // arrange
    when(dataSource.getLanguageList(NoParams()))
        .thenAnswer((_) async => Stubs.geLanguageListModel());
    // act
    final result = await repository.getLanguageList(NoParams());
    // assert
    expect(result, equals(Right(Stubs.geLanguageListModel())));
  });

  test('should success when getTranslation is called', () async* {
    final TranslateParams param =
        TranslateParams(inputText: 'demo', source: 'en', target: 'cs');
    // arrange
    when(dataSource.getTranslation(param))
        .thenAnswer((_) async => Stubs.getTranslateListModel());
    // act
    final result = await repository.getTranslation(param);
    // assert
    expect(result, equals(Right(Stubs.getTranslateListModel())));
  });
}
