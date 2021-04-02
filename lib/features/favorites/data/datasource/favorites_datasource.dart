import '../../../../core/db/hive_db_wrapper.dart';
import '../../../../resources/strings/string_keys.dart';
import '../../domain/entity/favorites_entity.dart';

class FavoritesLocalDataSource {
  final HiveDBWrapper hive;

  FavoritesLocalDataSource({required this.hive});

  Future<FavoritesEntity> getFavoriteTranslations() async {
    var box = await hive.openBox(StringKeys.favoriteBoxName);
    var result = await box.get(StringKeys.favoriteKeys);
    // check if no result was previously stored in db
    if (result == null) {
      box.put(StringKeys.favoriteKeys, FavoritesEntity(items: []));
      return FavoritesEntity(items: []);
    }
    return result;
  }

  Future<void> updateFavoriteTranslation(FavoritesEntity favorites) async {
    var box = await hive.openBox(StringKeys.favoriteBoxName);
    return box.put(StringKeys.favoriteKeys, favorites);
  }
}
