import 'package:equatable/equatable.dart';

class TranslateItemEntity extends Equatable {
  final String translatedText;

  TranslateItemEntity({required this.translatedText});

  @override
  List<Object?> get props => [translatedText];
}
