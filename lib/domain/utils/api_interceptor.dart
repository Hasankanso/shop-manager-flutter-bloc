import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:shop_manager/domain/utils/request_error.dart';

Future<Either<RequestError, R>> apiInterceptor<R>(
    Future<R> Function() func) async {
  try {
    final res = await func();
    return Right(res);
  } catch (e) {
    log("$e");
    return Left(RequestError(e));
  }
}
