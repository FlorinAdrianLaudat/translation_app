import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translation_app/resources/strings/string_keys.dart';

import '../../../../core/injection_container.dart';
import '../../domain/entity/language_item_entity.dart';
import '../bloc/translate_bloc.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final _languageTextController = TextEditingController(text: StringKeys.hello);
  late TranslateBloc _bloc;
  // list of displayed languages.
  List<LanguageItemEntity> _languages = [];
  // selected language from
  LanguageItemEntity _languageFrom = LanguageItemEntity(
      languageCode: StringKeys.detect, languageName: StringKeys.detect);
  int _selectedLanguageFromValue = 0;
  // selected language to
  LanguageItemEntity _languageTo = LanguageItemEntity(
      languageCode: StringKeys.detect, languageName: StringKeys.detect);
  //LanguageItemEntity(languageCode: 'cs', languageName: 'Czech');
  int _selectedLanguageToValue = 0;
  // the result of the translatation
  late String _result = '';
  // any detected language
  String _detectedLanguage = 'English';
  // if the text and the translated one are marked as favorites or not.
  bool isFavorite = false;

  @override
  void initState() {
    _bloc = di<TranslateBloc>();
    _bloc.add(GetAvailableLanguagesEvent());
    _bloc.add(GetLastLanguageSetEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) async {
        if (state is LanguageListLoadedState) {
          _languages = state.languages;
        } else if (state is LanguageSetState) {
          _languageFrom = state.languageFrom;
          _languageTo = state.languageTo;
          _selectedLanguageFromValue = _languages.indexOf(_languageFrom);
          _selectedLanguageToValue = _languages.indexOf(_languageTo);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white12,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                _inputGroup(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    StringKeys.translations,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                _translations(),
              ],
            ),
          ),
        );
      },
    );
  }

  _inputGroup() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              DropdownButton(
                items: _languages.map((LanguageItemEntity item) {
                  return DropdownMenuItem(
                    value: _languages.indexOf(item),
                    child: Text(
                      item.languageName,
                    ),
                  );
                }).toList(),
                value: _selectedLanguageFromValue,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguageFromValue = value as int;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:
                    IconButton(icon: Icon(Icons.swap_horiz), onPressed: () {}),
              ),
              // DropdownButton(
              //   items: _languages.map((LanguageItemEntity item) {
              //     return DropdownMenuItem(
              //       value: _languages.indexOf(item),
              //       child: Text(
              //         item.languageName,
              //       ),
              //     );
              //   }).toList(),
              //   value: _selectedLanguageToValue,
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedLanguageToValue = value as int;
              //     });
              //   },
              // ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(),
            onSaved: (String? value) {},
            maxLines: null,
            controller: _languageTextController,
          )
        ],
      ),
    );
  }

  _translations() {
    return Container(
      foregroundDecoration: BoxDecoration(color: Colors.white70),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(_languageTextController.text),
                Text(
                  _result,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Visibility(
                  visible: _languageFrom.languageName == StringKeys.detect,
                  child: Text(StringKeys.detectedLanguage + _detectedLanguage),
                )
              ],
            ),
          ),
          IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              }),
        ],
      ),
    );
  }
}
