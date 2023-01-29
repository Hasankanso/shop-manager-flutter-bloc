class RequestError extends Error {
  final dynamic error;

  RequestError(this.error);
  RequestError.fromHttp({statusCode, message})
      : error = Exception("Error $statusCode: $message");

  String get message => error.toString();
}
