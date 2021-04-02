import '../../domain/entity/language_list_entity.dart';
import 'language_item_model.dart';

class LanguageListModel extends LanguageListEntity {
  LanguageListModel({required languages}) : super(languages: languages);

  factory LanguageListModel.fromJson(Map<String, dynamic> json) {
    try {
      return LanguageListModel(languages: _parseList(json["data"]));
    } on Exception {
      return LanguageListModel(languages: <LanguageItemModel>[]);
    }
  }

  static _parseList(Map<String, dynamic> json) {
    final languages = json["languages"];
    List<LanguageItemModel> resultList = <LanguageItemModel>[];
    languages.forEach((lang) {
      resultList.add(LanguageItemModel.fromJson(lang));
    });
    return resultList;
  }
}
