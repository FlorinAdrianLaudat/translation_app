import 'package:equatable/equatable.dart';

class FavoriteTextEntryEntity extends Equatable {
  final String textToBeTranslated;
  final String translatedText;

  FavoriteTextEntryEntity(
      {required this.textToBeTranslated, required this.translatedText});

  @override
  List<Object?> get props => [textToBeTranslated, translatedText];
}
