import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../core/db/hive_type_id.dart';

part 'favorite_text_entry_entity.g.dart';

@HiveType(typeId: HiveTypeId.favoriteTextEntityId)
class FavoriteTextEntryEntity extends Equatable {
  @HiveField(0)
  final String textToBeTranslated;
  @HiveField(1)
  final String translatedText;

  FavoriteTextEntryEntity(
      {required this.textToBeTranslated, required this.translatedText});

  @override
  List<Object?> get props => [textToBeTranslated, translatedText];
}
