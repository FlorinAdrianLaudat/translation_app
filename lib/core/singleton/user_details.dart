import '../../features/favorites/domain/entity/favorite_text_entry_entity.dart';

class UserDetails {
  Set<FavoriteTextEntryEntity> favorites = {};

  addFavorite(FavoriteTextEntryEntity entry) {
    favorites.add(entry);
  }

  removeFavorite(FavoriteTextEntryEntity entry) {
    if (favorites.contains(entry)) {
      favorites.remove(entry);
    }
  }

  setFavorites(Set<FavoriteTextEntryEntity> newFavorites) {
    favorites.clear();
    favorites = newFavorites;
  }

  getFavorites() {
    return favorites;
  }
}
