import '../../domain/entity/translate_item_entity.dart';

class TranslateItemModel extends TranslateItemEntity {
  TranslateItemModel({
    required translatedText,
  }) : super(
          translatedText: translatedText,
        );

  factory TranslateItemModel.fromJson(Map<String, dynamic> json) {
    return TranslateItemModel(
      translatedText: json["translatedText"],
    );
  }
}
