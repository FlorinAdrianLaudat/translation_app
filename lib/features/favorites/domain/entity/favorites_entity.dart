import 'package:equatable/equatable.dart';

import 'favorite_text_entry_entity.dart';

class FavoritesEntity extends Equatable {
  final List<FavoriteTextEntryEntity> items;

  FavoritesEntity({required this.items});

  @override
  List<Object?> get props => [items];
}
