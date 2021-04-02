part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoritesEvent {
  final FavoriteTextEntryEntity favorite;

  AddFavorite({required this.favorite});

  @override
  List<Object> get props => [favorite];
}

class RemoveFavorite extends FavoritesEvent {
  final FavoriteTextEntryEntity favorite;

  RemoveFavorite({required this.favorite});

  @override
  List<Object> get props => [favorite];
}
