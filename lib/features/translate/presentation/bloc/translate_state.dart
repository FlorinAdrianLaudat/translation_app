part of 'translate_bloc.dart';

abstract class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

class InitState extends TranslateState {}

class LoadingState extends TranslateState {}

class ErrorState extends TranslateState {}

class LanguageSetState extends TranslateState {
  final int languageFrom;
  final int languageTo;

  LanguageSetState({required this.languageFrom, required this.languageTo});

  @override
  List<Object> get props => [languageFrom, languageTo];
}

class LanguagesStoredState extends TranslateState {}

class DetectedLanguageState extends TranslateState {
  final String detectedLanguage;
  final String textToBeTranslated;
  DetectedLanguageState(
      {required this.detectedLanguage, required this.textToBeTranslated});

  @override
  List<Object> get props => [detectedLanguage, textToBeTranslated];
}

class TranslatedTextState extends TranslateState {
  final String translatedText;

  TranslatedTextState({required this.translatedText});

  @override
  List<Object> get props => [translatedText];
}
