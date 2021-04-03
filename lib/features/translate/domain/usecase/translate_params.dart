import 'dart:convert';

class TranslateParams {
  final String inputText;
  final String source;
  final String target;

  TranslateParams(
      {required this.inputText, required this.source, required this.target});

  toJson() {
    return json.encode(
        {"q": inputText, "source": source, "target": target, "format": "text"});
  }
}
