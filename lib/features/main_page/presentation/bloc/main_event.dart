part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
  @override
  List<Object> get props => [];
}

class TranslatePressedEvent extends MainEvent {}

class FavoritesPressedEvent extends MainEvent {}

class GetAvailableLanguagesEvent extends MainEvent {}

class InitPreferredLanguageEvent extends MainEvent {}

class GetFavoritesEvent extends MainEvent {}
