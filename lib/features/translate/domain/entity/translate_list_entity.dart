import 'package:equatable/equatable.dart';

import 'translate_item_entity.dart';

class TranslateListEntity extends Equatable {
  final List<TranslateItemEntity> translations;

  TranslateListEntity({required this.translations});

  @override
  List<Object?> get props => [translations];
}
