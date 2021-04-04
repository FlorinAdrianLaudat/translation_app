import 'package:equatable/equatable.dart';

import 'detected_item_entity.dart';

class DetectedListEntity extends Equatable {
  final List<DetectedItemEntity> detectedEntries;

  DetectedListEntity({required this.detectedEntries});

  @override
  List<Object?> get props => [detectedEntries];

  get detectedLanguage {
    var entry;
    detectedEntries.forEach((element) {
      if (element.confidence == 1) {
        entry = element.language;
      }
    });
    if (entry != null) {
      return entry;
    }
    return detectedEntries[0].language;
  }
}
