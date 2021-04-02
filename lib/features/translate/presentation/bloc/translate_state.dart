part of 'translate_bloc.dart';

abstract class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

class InitState extends TranslateState {}

class LoadingState extends TranslateState {}

class ErrorState extends TranslateState {}

class NoNetworkState extends TranslateState {}

class LanguageListLoadedState extends TranslateState {
  final List<LanguageItemEntity> languages;

  LanguageListLoadedState({required this.languages});

  @override
  List<Object> get props => [languages];
}

class LanguageSetState extends TranslateState {
  final LanguageItemEntity languageFrom;
  final LanguageItemEntity languageTo;

  LanguageSetState({required this.languageFrom, required this.languageTo});

  @override
  List<Object> get props => [languageFrom, languageTo];
}
