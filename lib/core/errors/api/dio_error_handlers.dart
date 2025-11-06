
import '../error_handler_service.dart';
import '../failures.dart';
import 'api_response_codes.dart';

class ConnectionTimeOutErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return const ServerFailure(
      statusCode: APIResponseCodes.connectTimeout,
      message: "Connection timed out",
    );
  }
}

class SendTimeOutErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return const ServerFailure(
      statusCode: APIResponseCodes.sendTimeout,
      message: "Send timed out",
    );
  }
}

class ReceiveTimeOutErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return const ServerFailure(
      statusCode: APIResponseCodes.receiveTimeout,
      message: "Receive timed out",
    );
  }
}

class CancelErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return const ServerFailure(
      statusCode: APIResponseCodes.cancel,
      message: "Request canceled",
    );
  }
}

class BadCertificateErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return const ServerFailure(
      statusCode: APIResponseCodes.badRequest,
      message: "Bad request",
    );
  }
}

class UnknownErrorHandler implements ErrorHandlerService {
  @override
  Failure handle(Exception exception) {
    return const ServerFailure(
      statusCode: APIResponseCodes.unknown,
      message: "unknown error occurred",
    );
  }
}
