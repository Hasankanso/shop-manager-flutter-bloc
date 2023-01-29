import 'package:shop_manager/domain/utils/request_error.dart';

class ApiRequestFailure {
  final RequestError error;

  ApiRequestFailure(this.error);

  String get message {
    try {
      return error.message;
    } catch (e) {
      return "$e";
    }
  }
}
