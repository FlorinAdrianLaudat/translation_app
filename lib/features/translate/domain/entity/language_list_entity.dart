import 'package:equatable/equatable.dart';
import 'language_item_entity.dart';

class LanguageListEntity extends Equatable {
  final List<LanguageItemEntity> languages;

  LanguageListEntity({required this.languages});

  @override
  List<Object?> get props => [languages];
}
