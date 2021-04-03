import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/detected_list_entity.dart';

abstract class DetectLanguageRepository {
  Future<Either<Failure, DetectedListEntity>> getDetectedLanguages(
      String input);
}
