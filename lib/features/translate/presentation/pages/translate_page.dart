import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/domain/entity/favorite_text_entry_entity.dart';

import '../../../../core/injection_container.dart';
import '../../../../resources/strings/string_keys.dart';
import '../../domain/entity/language_item_entity.dart';
import '../bloc/translate_bloc.dart';

class TranslatePage extends StatefulWidget {
  /// list of displayed languages.
  final List<LanguageItemEntity> languages;

  TranslatePage({required this.languages});

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final _languageTextController = TextEditingController(text: StringKeys.hello);
  late TranslateBloc _bloc;
  int _selectedLanguageFromValue = 0;
  int _selectedLanguageToValue = 0;
  // the result of the translatation
  late String _result = 'test';
  // any detected language
  String _detectedLanguage = 'English';
  // if the text translation is marked as favorites or not.
  bool isFavorite = false;

  @override
  void initState() {
    _bloc = di<TranslateBloc>();
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
        if (state is LanguageSetState) {
          _selectedLanguageFromValue = state.languageFrom;
          _selectedLanguageToValue = state.languageTo;
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Color(0xffebebeb),
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  _inputGroup(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      StringKeys.translations,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _translations(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _inputGroup() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2.0)),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                DropdownButton(
                  items: widget.languages.map((LanguageItemEntity item) {
                    return DropdownMenuItem(
                      value: widget.languages.indexOf(item),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.29,
                        child: Text(
                          item.languageName,
                        ),
                      ),
                    );
                  }).toList(),
                  value: _selectedLanguageFromValue,
                  onChanged: (value) {
                    setState(() {
                      if (value == _selectedLanguageToValue + 1) {
                        // additional check for Detect language - cannot set to languageTo
                        if (_selectedLanguageFromValue == 0) {
                          // set a default english or czech value
                          // TODO
                          _selectedLanguageToValue = 3;
                        } else {
                          _selectedLanguageToValue =
                              _selectedLanguageFromValue - 1;
                        }
                      }
                      _selectedLanguageFromValue = value as int;
                    });
                    _bloc.add(ChangeLanguageEvent(
                        isLanguageFrom: true,
                        languageIndex: _selectedLanguageFromValue));
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: IconButton(
                    icon: Icon(Icons.swap_horiz),
                    onPressed: _selectedLanguageFromValue != 0
                        ? () {
                            setState(() {
                              final i = _selectedLanguageFromValue - 1;
                              _selectedLanguageFromValue =
                                  _selectedLanguageToValue + 1;
                              _selectedLanguageToValue = i;
                            });
                          }
                        : null,
                    disabledColor: Colors.grey,
                  ),
                ),
                DropdownButton(
                  items: (widget.languages.length > 0
                          ? widget.languages.sublist(1)
                          : widget.languages)
                      .map((LanguageItemEntity item) {
                    return DropdownMenuItem(
                      value: widget.languages.sublist(1).indexOf(item),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.29,
                        child: Text(
                          item.languageName,
                        ),
                      ),
                    );
                  }).toList(),
                  value: _selectedLanguageToValue,
                  onChanged: (value) {
                    setState(() {
                      if (value == _selectedLanguageFromValue - 1) {
                        _selectedLanguageFromValue =
                            _selectedLanguageToValue + 1;
                      }
                      _selectedLanguageToValue = value as int;
                    });
                    _bloc.add(ChangeLanguageEvent(
                        isLanguageFrom: false,
                        languageIndex: _selectedLanguageToValue));
                  },
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(),
              onSaved: (String? value) {},
              maxLines: null,
              maxLength: 5000,
              controller: _languageTextController,
              onChanged: (value) {
                setState(() {
                  isFavorite = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  _translations() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2.0)),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_languageTextController.text),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: _selectedLanguageFromValue == 0,
                    child: Text(StringKeys.detectedLanguage + _detectedLanguage,
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                ],
              ),
            ),
            IconButton(
                icon:
                    Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
                onPressed: () {
                  if (!isFavorite) {
                    setState(() {
                      isFavorite = true;
                    });
                    _bloc.add(
                      UpdateFavoritesEvent(
                        entry: FavoriteTextEntryEntity(
                            textToBeTranslated: _languageTextController.text,
                            translatedText: _result),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
