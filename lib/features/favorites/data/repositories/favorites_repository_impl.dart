import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/favorites_entity.dart';
import '../../domain/repository/favorites_repository.dart';
import '../datasource/favorites_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource dataSource;

  FavoritesRepositoryImpl({
    required this.dataSource,
  });

  Future<Either<Failure, FavoritesEntity>> getFavoriteTranslations() async {
    try {
      final result = await dataSource.getFavoriteTranslations();
      return Right(result);
    } on Exception {
      return Left(LocalCacheFailure());
    }
  }

  Future<Either<Failure, void>> updateFavoriteTranslation(
      FavoritesEntity favorites) async {
    try {
      return Right(dataSource.updateFavoriteTranslation(favorites));
    } on Exception {
      return Left(LocalCacheFailure());
    }
  }
}
