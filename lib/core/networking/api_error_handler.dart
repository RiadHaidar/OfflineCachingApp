import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Please check your internet connection.';
        case DioExceptionType.sendTimeout:
          return 'Send timeout. Please try again.';
        case DioExceptionType.receiveTimeout:
          return 'Receive timeout. Please try again.';
        case DioExceptionType.badResponse:
          return _handleBadResponse(error);
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.connectionError:
          return 'No internet connection. Please check your network.';
        case DioExceptionType.badCertificate:
          return 'Bad certificate. Please try again later.';
        case DioExceptionType.unknown:
          return 'An unexpected error occurred. Please try again.';
      }
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    switch (statusCode) {
      case 400:
        return _extractErrorMessage(data) ?? 'Bad request. Please try again.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You do not have permission to access this resource.';
      case 404:
        return 'The requested resource was not found.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      try {
        final errorModel = ApiErrorModel.fromJson(data);
        return errorModel.message;
      } catch (e) {
        // If parsing fails, try to extract message directly
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
        if (data.containsKey('error')) {
          return data['error'].toString();
        }
      }
    }
    return null;
  }
}
