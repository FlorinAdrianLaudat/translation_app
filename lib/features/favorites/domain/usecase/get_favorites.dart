import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/favorites_entity.dart';
import '../repository/favorites_repository.dart';

class GetFavorites implements UseCase<FavoritesEntity, NoParams> {
  final FavoritesRepository repository;

  GetFavorites({required this.repository});

  @override
  Future<Either<Failure, FavoritesEntity>> call(NoParams params) async {
    return await repository.getFavoriteTranslations();
  }
}
