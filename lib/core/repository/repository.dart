import 'package:dartz/dartz.dart';

import '../error/failures.dart';
import '../network/network_info.dart';

class Repository {
  final NetworkInfo networkInfo;

  Repository({
    required this.networkInfo,
  });

  Future<Either<Failure, T>> call<T>(
    FactoryFunction<Future<T>> remoteFactoryFunction,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        var res = await remoteFactoryFunction();
        return Right(res);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

typedef FactoryFunction<T> = T Function();
