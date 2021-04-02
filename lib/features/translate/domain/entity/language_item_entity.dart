import 'package:equatable/equatable.dart';

class LanguageItemEntity extends Equatable {
  final String languageCode;
  final String languageName;

  LanguageItemEntity({required this.languageCode, required this.languageName});

  @override
  List<Object?> get props => [languageCode, languageName];
}
