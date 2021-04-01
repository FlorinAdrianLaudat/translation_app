import '../../../../core/db/hive_db_wrapper.dart';
import '../../../../resources/strings/string_keys.dart';
import '../../domain/entity/favorites_entity.dart';

class FavoritesLocalDataSource {
  final HiveDBWrapper hive;

  FavoritesLocalDataSource({required this.hive});

  Future<FavoritesEntity> getFavoriteTranslations() async {
    var box = await hive.openBox(StringKeys.favoriteBoxName);
    return box.get(StringKeys.favoriteKeys);
  }

  Future<void> addFavoriteTranslation(FavoritesEntity favorites) async {
    var box = await hive.openBox(StringKeys.favoriteBoxName);
    return box.put(StringKeys.favoriteKeys, favorites);
  }
}
