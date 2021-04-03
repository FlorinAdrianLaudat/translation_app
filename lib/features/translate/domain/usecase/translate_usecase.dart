import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/translate_list_entity.dart';
import '../repository/translate_repository.dart';
import 'translate_params.dart';

class TranslateUseCase extends UseCase<TranslateListEntity, TranslateParams> {
  final TranslateRepository repository;

  TranslateUseCase({required this.repository});

  @override
  Future<Either<Failure, TranslateListEntity>> call(
      TranslateParams params) async {
    var result = await repository.getTranslation(params);
    return result;
  }
}
