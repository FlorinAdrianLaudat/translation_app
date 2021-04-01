part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class TranslatePressedEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class FavoritesPressedEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}
