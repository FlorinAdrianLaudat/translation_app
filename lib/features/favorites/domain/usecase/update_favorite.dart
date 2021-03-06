import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/favorites_entity.dart';
import '../repository/favorites_repository.dart';

class UpdateFavorites implements UseCase<void, FavoritesEntity> {
  final FavoritesRepository repository;

  UpdateFavorites({required this.repository});

  @override
  Future<Either<Failure, void>> call(FavoritesEntity favorites) async {
    return repository.updateFavoriteTranslation(favorites);
  }
}
