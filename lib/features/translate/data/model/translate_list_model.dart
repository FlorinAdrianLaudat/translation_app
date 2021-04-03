import '../../domain/entity/translate_list_entity.dart';
import 'translate_item_model.dart';

class TranslateListModel extends TranslateListEntity {
  TranslateListModel({required translations})
      : super(translations: translations);

  factory TranslateListModel.fromJson(Map<String, dynamic> json) {
    try {
      return TranslateListModel(translations: _parseList(json["data"]));
    } on Exception {
      return TranslateListModel(translations: <TranslateItemModel>[]);
    }
  }

  static _parseList(Map<String, dynamic> json) {
    final translations = json["translations"];
    List<TranslateItemModel> resultList = <TranslateItemModel>[];
    translations.forEach((translation) {
      resultList.add(TranslateItemModel.fromJson(translation));
    });
    return resultList;
  }
}
