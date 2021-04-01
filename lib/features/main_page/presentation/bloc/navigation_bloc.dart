import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(TranslatePageState());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is TranslatePressedEvent) {
      yield TranslatePageState();
    } else if (event is FavoritesPressedEvent) {
      yield FavoritesPageState();
    }
  }
}
