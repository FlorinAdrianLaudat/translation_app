part of 'translate_bloc.dart';

abstract class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

class InitState extends TranslateState {}

class LoadingState extends TranslateState {}

class LanguageSetState extends TranslateState {
  final int languageFrom;
  final int languageTo;

  LanguageSetState({required this.languageFrom, required this.languageTo});

  @override
  List<Object> get props => [languageFrom, languageTo];
}

class LanguagesStoredState extends TranslateState {}
