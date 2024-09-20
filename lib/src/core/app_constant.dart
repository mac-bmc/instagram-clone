import "package:dio/dio.dart" as dio;
class NetworkClient {
  NetworkClient._();

  static final dio.BaseOptions _options = dio.BaseOptions(
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
  );

  static dio.Dio? _dio;


  static dio.Dio get dioInstance {
    _dio ??= dio.Dio(_options);
    return _dio!;
  }
}

//Create a dio instance with the headers for email otp api.
//