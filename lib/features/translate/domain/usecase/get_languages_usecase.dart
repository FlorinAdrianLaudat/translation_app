import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/language_list_entity.dart';
import '../repository/translate_repository.dart';

class GetLanguagesUseCase extends UseCase<LanguageListEntity, NoParams> {
  final TranslateRepository repository;

  GetLanguagesUseCase({required this.repository});

  @override
  Future<Either<Failure, LanguageListEntity>> call(NoParams params) async {
    var result = await repository.getLanguageList(params);
    return result;
  }
}
