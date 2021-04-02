import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/injection_container.dart';
import '../../../../core/singleton/user_details.dart';
import '../../../../resources/shared_preferences/shared_preferences_keys.dart';
import '../../../favorites/domain/entity/favorite_text_entry_entity.dart';
import '../../../favorites/domain/entity/favorites_entity.dart';
import '../../../favorites/domain/usecase/update_favorite.dart';
import '../../domain/usecase/get_languages_usecase.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final GetLanguagesUseCase languagesUseCase;
  final SharedPreferences sharedPreferences;
  final UpdateFavorites updateFavorite;

  TranslateBloc({
    required this.languagesUseCase,
    required this.sharedPreferences,
    required this.updateFavorite,
  }) : super(InitState());

  @override
  Stream<TranslateState> mapEventToState(TranslateEvent event) async* {
    if (event is GetLastLanguageSetEvent) {
      yield* _getLastLanguagesSet();
    } else if (event is ChangeLanguageEvent) {
      yield* _setLastLanguagesUsed(event.isLanguageFrom, event.languageIndex);
    } else if (event is UpdateFavoritesEvent) {
      yield* _updateFavorites(event.entry);
    }
  }

  Stream<TranslateState> _getLastLanguagesSet() async* {
    yield LoadingState();
    final languageFrom =
        sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_FROM);
    final languageTo = sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_TO);
    if (languageFrom == null || languageTo == null) {
      // not yet initialise
      yield LanguageSetState(languageFrom: 0, languageTo: 0);
    } else {
      yield LanguageSetState(
        languageFrom:
            sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_FROM) as int,
        languageTo:
            sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_TO) as int,
      );
    }
  }

  Stream<TranslateState> _setLastLanguagesUsed(
      bool isFrom, int langIndex) async* {
    yield LoadingState();
    if (isFrom) {
      sharedPreferences.setInt(SharedPreferencesKeys.LANGUAGE_FROM, langIndex);
    } else {
      sharedPreferences.setInt(SharedPreferencesKeys.LANGUAGE_TO, langIndex);
    }
    yield LanguagesStoredState();
  }

  Stream<TranslateState> _updateFavorites(
      FavoriteTextEntryEntity entry) async* {
    yield LoadingState();
    di<UserDetails>().addFavorite(entry);
    updateFavorite
        .call(FavoritesEntity(items: di<UserDetails>().favorites.toList()));
    yield LanguagesStoredState();
  }
}
