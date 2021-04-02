import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection_container.dart';
import '../../../../core/singleton/user_details.dart';
import '../../domain/entity/favorite_text_entry_entity.dart';
import '../../domain/entity/favorites_entity.dart';
import '../../domain/usecase/update_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  UpdateFavorites updateFavorites;

  FavoritesBloc({required this.updateFavorites}) : super(InitialState());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is AddFavorite) {
      yield* _updateFavorites(event.favorite);
    } else if (event is RemoveFavorite) {
      yield* _updateFavorites(event.favorite);
    }
  }

  Stream<FavoritesState> _updateFavorites(
      FavoriteTextEntryEntity favorite) async* {
    yield LoadingState();
    updateFavorites
        .call(FavoritesEntity(items: di<UserDetails>().favorites.toList()));
    yield CompleteState();
  }
}
