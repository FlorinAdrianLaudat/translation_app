import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class LocalCacheFailure extends Failure {}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}
