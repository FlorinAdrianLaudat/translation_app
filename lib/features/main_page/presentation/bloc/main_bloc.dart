import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/singleton/user_details.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../resources/shared_preferences/shared_preferences_keys.dart';
import '../../../../resources/strings/string_keys.dart';
import '../../../favorites/domain/usecase/get_favorites.dart';
import '../../../translate/domain/entity/language_item_entity.dart';
import '../../../translate/domain/usecase/get_languages_usecase.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetLanguagesUseCase languagesUseCase;
  final SharedPreferences sharedPreferences;
  final GetFavorites getFavorites;

  MainBloc(
      {required this.languagesUseCase,
      required this.sharedPreferences,
      required this.getFavorites})
      : super(InitState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is TranslatePressedEvent) {
      yield TranslatePageState();
    } else if (event is FavoritesPressedEvent) {
      yield FavoritesPageState();
    } else if (event is GetAvailableLanguagesEvent) {
      yield* _getLanguageList();
    } else if (event is InitPreferredLanguageEvent) {
      yield* _initSharedPreferrences();
    } else if (event is GetFavoritesEvent) {
      yield* _getFavorites();
    }
  }

  Stream<MainState> _getLanguageList() async* {
    yield LoadingState();
    final result = await languagesUseCase(NoParams());
    yield result.fold((failure) {
      if (failure is NetworkFailure) {
        return NoNetworkState();
      } else {
        return ErrorState();
      }
    }, (languageList) {
      List<LanguageItemEntity> languages = [
        LanguageItemEntity(
            languageCode: StringKeys.detect, languageName: StringKeys.detect)
      ];
      languages.addAll(languageList.languages);
      return LanguageListLoadedState(languages: languages);
    });
  }

  Stream<MainState> _initSharedPreferrences() async* {
    yield LoadingState();
    if (sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_FROM) == null) {
      // save a default detect translate from language
      sharedPreferences.setInt(SharedPreferencesKeys.LANGUAGE_FROM, 0);
    }
    if (sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_TO) == null) {
      sharedPreferences.setInt(SharedPreferencesKeys.LANGUAGE_TO, 19);
    }
    yield CompleteState();
  }

  Stream<MainState> _getFavorites() async* {
    yield LoadingState();
    final result = await getFavorites(NoParams());
    yield result.fold((failure) {
      return ErrorState();
    }, (favorites) {
      di<UserDetails>().setFavorites(favorites.items.toSet());
      return CompleteState();
    });
  }
}
