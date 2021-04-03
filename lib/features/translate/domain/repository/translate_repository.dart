import 'package:dartz/dartz.dart';
import '../entity/translate_list_entity.dart';
import '../usecase/translate_params.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/language_list_entity.dart';

abstract class TranslateRepository {
  Future<Either<Failure, LanguageListEntity>> getLanguageList(NoParams params);
  Future<Either<Failure, TranslateListEntity>> getTranslation(
      TranslateParams params);
}
