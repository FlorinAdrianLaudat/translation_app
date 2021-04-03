import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/detected_list_entity.dart';
import '../repository/detect_language_repository.dart';

class DetectLanguageUseCase extends UseCase<DetectedListEntity, String> {
  final DetectLanguageRepository repository;

  DetectLanguageUseCase({required this.repository});

  @override
  Future<Either<Failure, DetectedListEntity>> call(String input) async {
    var result = await repository.getDetectedLanguages(input);
    return result;
  }
}
