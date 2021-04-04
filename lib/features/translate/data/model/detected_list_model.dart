import '../../domain/entity/detected_list_entity.dart';
import 'detected_item_model.dart';

class DetectedListModel extends DetectedListEntity {
  DetectedListModel({required detectedEntries})
      : super(detectedEntries: detectedEntries);

  factory DetectedListModel.fromJson(Map<String, dynamic> json) {
    try {
      return DetectedListModel(detectedEntries: _parseList(json["data"]));
    } on Exception {
      return DetectedListModel(detectedEntries: <DetectedItemModel>[]);
    }
  }

  static _parseList(Map<String, dynamic> json) {
    final detectedEntries = json["detections"][0];
    List<DetectedItemModel> resultList = <DetectedItemModel>[];
    detectedEntries.forEach((lang) {
      resultList.add(DetectedItemModel.fromJson(lang));
    });
    return resultList;
  }
}
