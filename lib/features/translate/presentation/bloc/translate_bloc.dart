import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';

import '../../../../core/injection_container.dart';
import '../../../../core/singleton/user_details.dart';
import '../../../../resources/shared_preferences/shared_preferences_keys.dart';
import '../../../favorites/domain/entity/favorite_text_entry_entity.dart';
import '../../../favorites/domain/entity/favorites_entity.dart';
import '../../../favorites/domain/usecase/update_favorite.dart';
import '../../domain/usecase/detect_language_usecase.dart';
import '../../domain/usecase/get_languages_usecase.dart';
import '../../domain/usecase/translate_params.dart';
import '../../domain/usecase/translate_usecase.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final GetLanguagesUseCase languagesUseCase;
  final SharedPreferences sharedPreferences;
  final UpdateFavorites updateFavorite;
  final DetectLanguageUseCase detectLanguageUseCase;
  final TranslateUseCase translateUseCase;

  TranslateBloc({
    required this.languagesUseCase,
    required this.sharedPreferences,
    required this.updateFavorite,
    required this.detectLanguageUseCase,
    required this.translateUseCase,
  }) : super(InitState());

  @override
  Stream<TranslateState> mapEventToState(TranslateEvent event) async* {
    if (event is GetLastLanguageSetEvent) {
      yield* _getLastLanguagesSet();
    } else if (event is ChangeLanguageEvent) {
      yield* _setLastLanguagesUsed(event.isLanguageFrom, event.languageIndex);
    } else if (event is UpdateFavoritesEvent) {
      yield* _updateFavorites(event.entry);
    } else if (event is GetDetectedLanguageEvent) {
      yield* _detectLanguage(event.inputText);
    } else if (event is TranslateTextEvent) {
      yield* _translateText(
          event.inputText, event.sourceLanguage, event.targetLanguage);
    }
  }

  Stream<TranslateState> _getLastLanguagesSet() async* {
    yield LoadingState();
    final languageFrom =
        sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_FROM);
    final languageTo = sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_TO);
    if (languageFrom == null || languageTo == null) {
      // not yet initialise
      yield LanguageSetState(languageFrom: 0, languageTo: 21);
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
    final result = await updateFavorite
        .call(FavoritesEntity(items: di<UserDetails>().favorites.toList()));
    yield result.fold((failure) {
      return ErrorState();
    }, (language) {
      return UpdateFavoritesState();
    });
  }

  Stream<TranslateState> _detectLanguage(String inputText) async* {
    yield LoadingState();
    final result = await detectLanguageUseCase(inputText);
    yield result.fold((failure) {
      if (failure is NetworkFailure) {
        return NoNetworkState();
      } else {
        return ErrorState();
      }
    }, (detect) {
      return DetectedLanguageState(
          detectedLanguage: detect.detectedLanguage,
          textToBeTranslated: inputText);
    });
  }

  Stream<TranslateState> _translateText(
      String inputText, String sourceLanguage, String targetLanguage) async* {
    yield LoadingState();
    if (sourceLanguage == targetLanguage) {
      yield TranslatedTextState(translatedText: inputText);
      return;
    }
    final result = await translateUseCase(
      TranslateParams(
          inputText: inputText, source: sourceLanguage, target: targetLanguage),
    );
    yield result.fold((failure) {
      if (failure is NetworkFailure) {
        return NoNetworkState();
      } else {
        return ErrorState();
      }
    }, (translatedList) {
      return TranslatedTextState(
          translatedText: translatedList.translations.first.translatedText);
    });
  }
}
