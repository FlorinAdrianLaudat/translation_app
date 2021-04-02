import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/repository/repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/language_list_entity.dart';
import '../../domain/repository/translate_repository.dart';
import '../datasource/translate_datasource.dart';

class TranslateRepositoryImpl extends TranslateRepository {
  final TranslateDataSource dataSource;
  final Repository repository;

  TranslateRepositoryImpl({required this.dataSource, required this.repository});

  @override
  Future<Either<Failure, LanguageListEntity>> getLanguageList(NoParams params) {
    return repository.call<LanguageListEntity>(
      () => dataSource.getLanguageList(params),
    );
  }
}
