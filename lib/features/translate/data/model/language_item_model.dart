import '../../domain/entity/language_item_entity.dart';

class LanguageItemModel extends LanguageItemEntity {
  LanguageItemModel({
    required languageCode,
    required languageName,
  }) : super(languageCode: languageCode, languageName: languageName);

  factory LanguageItemModel.fromJson(Map<String, dynamic> json) {
    return LanguageItemModel(
      languageCode: json["language"],
      languageName: json["name"],
    );
  }
}
