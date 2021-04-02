part of 'translate_bloc.dart';

abstract class TranslateEvent extends Equatable {
  const TranslateEvent();

  @override
  List<Object?> get props => [];
}

class GetAvailableLanguagesEvent extends TranslateEvent {}

class GetLastLanguageSetEvent extends TranslateEvent {}
