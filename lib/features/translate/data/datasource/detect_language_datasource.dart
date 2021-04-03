import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/injection_container.dart';
import '../../../../resources/network/network_constants.dart';
import '../model/detected_list_model.dart';

class DetectLanguageDataSource {
  Future<DetectedListModel> getDetectedLanguages(String input) async {
    NetworkConstants networkConstants = di<NetworkConstants>();
    String url = networkConstants.googleTranslateURL +
        networkConstants.detectURL +
        networkConstants.tokenGTAPI;
    var body = {};
    body["q"] = input;
    final response = await http.post(Uri.parse(url), body: json.encode(body));
    if (response.statusCode == 200) {
      return DetectedListModel.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Wrong answer');
    }
  }
}
