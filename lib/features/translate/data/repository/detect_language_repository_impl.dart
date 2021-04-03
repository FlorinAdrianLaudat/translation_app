import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/repository/repository.dart';
import '../../domain/entity/detected_list_entity.dart';
import '../../domain/repository/detect_language_repository.dart';
import '../datasource/detect_language_datasource.dart';

class DetectLanguageRepositoryImpl extends DetectLanguageRepository {
  final DetectLanguageDataSource dataSource;
  final Repository repository;

  DetectLanguageRepositoryImpl(
      {required this.dataSource, required this.repository});

  @override
  Future<Either<Failure, DetectedListEntity>> getDetectedLanguages(
      String input) {
    return repository.call<DetectedListEntity>(
      () => dataSource.getDetectedLanguages(input),
    );
  }
}
