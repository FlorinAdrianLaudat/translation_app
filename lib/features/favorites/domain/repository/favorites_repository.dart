import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/favorites_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, FavoritesEntity>> getFavoriteTranslations();
  Future<Either<Failure, void>> updateFavoriteTranslation(
      FavoritesEntity favorites);
}
