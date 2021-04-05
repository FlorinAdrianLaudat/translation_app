import 'package:translation_app/features/translate/data/model/language_list_model.dart';
import 'package:translation_app/features/translate/data/model/translate_list_model.dart';

class Stubs {
  static geLanguageListModel() {
    return LanguageListModel.fromJson(getLanguages());
  }

  static TranslateListModel getTranslateListModel() {
    return TranslateListModel.fromJson(getTranslateList());
  }

  static getLanguages() {
    return {
      "data": {
        "languages": [
          {"language": "af", "name": "Afrikaans"},
          {"language": "sq", "name": "Albanian"},
          {"language": "am", "name": "Amharic"},
          {"language": "ar", "name": "Arabic"},
          {"language": "hy", "name": "Armenian"},
          {"language": "az", "name": "Azerbaijani"},
          {"language": "eu", "name": "Basque"},
          {"language": "be", "name": "Belarusian"},
          {"language": "cs", "name": "Czech"},
        ]
      }
    };
  }

  static getTranslateList() {
    return {
      "data": {
        "translations": [
          {"translatedText": "Translated text"}
        ]
      }
    };
  }
}
