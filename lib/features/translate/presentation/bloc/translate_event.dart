part of 'translate_bloc.dart';

abstract class TranslateEvent extends Equatable {
  const TranslateEvent();

  @override
  List<Object?> get props => [];
}

class GetLastLanguageSetEvent extends TranslateEvent {}

class ChangeLanguageEvent extends TranslateEvent {
  final int languageIndex;
  final bool isLanguageFrom;

  ChangeLanguageEvent(
      {required this.languageIndex, required this.isLanguageFrom});

  @override
  List<Object?> get props => [languageIndex, isLanguageFrom];
}

class UpdateFavoritesEvent extends TranslateEvent {
  final FavoriteTextEntryEntity entry;

  UpdateFavoritesEvent({required this.entry});

  @override
  List<Object?> get props => [entry];
}
