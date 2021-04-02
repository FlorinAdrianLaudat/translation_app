import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/language_list_entity.dart';

abstract class TranslateRepository {
  Future<Either<Failure, LanguageListEntity>> getLanguageList(NoParams params);
}
