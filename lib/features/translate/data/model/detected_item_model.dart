import '../../domain/entity/detected_item_entity.dart';

class DetectedItemModel extends DetectedItemEntity {
  DetectedItemModel({
    required language,
    required confidence,
    required isReliable,
  }) : super(
          language: language,
          confidence: confidence,
          isReliable: isReliable,
        );

  factory DetectedItemModel.fromJson(Map<String, dynamic> json) {
    return DetectedItemModel(
      language: json["language"],
      confidence: json["confidence"],
      isReliable: json["isReliable"],
    );
  }
}
