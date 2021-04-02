part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
  @override
  List<Object> get props => [];
}

class InitState extends MainState {}

class LoadingState extends MainState {}

class ErrorState extends MainState {}

class NoNetworkState extends MainState {}

class TranslatePageState extends MainState {}

class FavoritesPageState extends MainState {}

class LanguageListLoadedState extends MainState {
  final List<LanguageItemEntity> languages;

  LanguageListLoadedState({required this.languages});

  @override
  List<Object> get props => [languages];
}

class CompleteState extends MainState {}
