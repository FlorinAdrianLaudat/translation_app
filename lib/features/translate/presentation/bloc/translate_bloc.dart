import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../resources/shared_preferences/shared_preferences_keys.dart';
import '../../../../resources/strings/string_keys.dart';
import '../../domain/entity/language_item_entity.dart';
import '../../domain/usecase/get_languages_usecase.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final GetLanguagesUseCase languagesUseCase;
  final SharedPreferences sharedPreferences;

  TranslateBloc(
      {required this.languagesUseCase, required this.sharedPreferences})
      : super(InitState());

  @override
  Stream<TranslateState> mapEventToState(TranslateEvent event) async* {
    if (event is GetAvailableLanguagesEvent) {
      yield* _getLanguageList();
    } else if (event is GetLastLanguageSetEvent) {
      yield* _getLastLanguagesSet();
    }
  }

  Stream<TranslateState> _getLanguageList() async* {
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

  Stream<TranslateState> _getLastLanguagesSet() async* {
    yield LoadingState();
    if (sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_FROM) == null) {
      // save a default detect translate from language
      sharedPreferences.setString(
          SharedPreferencesKeys.LANGUAGE_FROM, StringKeys.detect);
      sharedPreferences.setString(
          SharedPreferencesKeys.LANGUAGE_FROM_NAME, StringKeys.detect);
    }
    if (sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_TO) == null) {
      // save a default czech translate to language
      sharedPreferences.setString(SharedPreferencesKeys.LANGUAGE_TO, 'cs');
      sharedPreferences.setString(
          SharedPreferencesKeys.LANGUAGE_TO_NAME, 'Czech');
    }
    yield LanguageSetState(
      languageFrom: LanguageItemEntity(
        languageCode: sharedPreferences
            .get(SharedPreferencesKeys.LANGUAGE_FROM)
            .toString(),
        languageName: sharedPreferences
            .get(SharedPreferencesKeys.LANGUAGE_FROM_NAME)
            .toString(),
      ),
      languageTo: LanguageItemEntity(
        languageCode:
            sharedPreferences.get(SharedPreferencesKeys.LANGUAGE_TO).toString(),
        languageName: sharedPreferences
            .get(SharedPreferencesKeys.LANGUAGE_TO_NAME)
            .toString(),
      ),
    );
  }
}
