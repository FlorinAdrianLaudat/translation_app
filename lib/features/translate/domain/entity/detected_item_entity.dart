import 'package:equatable/equatable.dart';

class DetectedItemEntity extends Equatable {
  final String language;
  final int confidence;
  final bool isReliable;

  DetectedItemEntity(
      {required this.language,
      required this.confidence,
      required this.isReliable});

  @override
  List<Object?> get props => [language, confidence, isReliable];
}
