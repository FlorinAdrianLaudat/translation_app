import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/injection_container.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../resources/network/network_constants.dart';
import '../model/language_list_model.dart';

class TranslateDataSource {
  Future<LanguageListModel> getLanguageList(NoParams params) async {
    NetworkConstants networkConstants = di<NetworkConstants>();
    String url = networkConstants.googleTranslateURL +
        networkConstants.languageURL +
        networkConstants.tokenGTAPI;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return LanguageListModel.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Wrong answer');
    }
  }
}
