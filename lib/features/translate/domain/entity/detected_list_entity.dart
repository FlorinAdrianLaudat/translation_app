import 'package:equatable/equatable.dart';

import 'language_item_entity.dart';

class DetectedListEntity extends Equatable {
  final List<LanguageItemEntity> detectedEntries;

  DetectedListEntity({required this.detectedEntries});

  @override
  List<Object?> get props => [detectedEntries];
}
