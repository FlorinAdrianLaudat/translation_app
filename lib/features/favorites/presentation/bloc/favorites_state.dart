part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends FavoritesState {}

class LoadingState extends FavoritesState {}

class CompleteState extends FavoritesState {}
