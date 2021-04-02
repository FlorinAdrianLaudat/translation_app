import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;

import '../../../../core/usecase/usecase.dart';
import '../model/language_list_model.dart';

class TranslateDataSource {
  Future<LanguageListModel> getLanguageList(NoParams params) async {
    return LanguageListModel.fromJson(TranslateDataSource.guis());
    // NetworkConstants networkConstants = di<NetworkConstants>();
    // String url = networkConstants.googleTranslateURL +
    //     networkConstants.languageURL +
    //     networkConstants.tokenGTAPI;
    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   return LanguageListModel.fromJson(json.decode(response.body));
    // } else {
    //   throw HttpException('Wrong answer');
    // }
  }

  static guis() {
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
}
