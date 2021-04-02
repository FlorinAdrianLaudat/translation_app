import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../core/db/hive_type_id.dart';
import 'favorite_text_entry_entity.dart';

part 'favorites_entity.g.dart';

@HiveType(typeId: HiveTypeId.favoritesEntityId)
class FavoritesEntity extends Equatable {
  @HiveField(0)
  final List<FavoriteTextEntryEntity> items;

  FavoritesEntity({required this.items});

  @override
  List<Object?> get props => [items];
}
