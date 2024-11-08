import 'dart:developer';

import 'package:doctors_app/core/data/networking/api_service.dart';

import '../../../../../core/data/error/failures.dart';
import '../../../../../core/data/networking/api_error_handler.dart';
import '../models/login_request_body_model.dart';
import '../models/login_response_model.dart';

abstract class BaseLoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequestBody loginRequestBody);
}

class LoginRemoteDataSource extends BaseLoginRemoteDataSource {
  final ApiService apiService;

  LoginRemoteDataSource({required this.apiService});

  @override
  Future<LoginResponse> login(LoginRequestBody loginRequestBody) async {
    try {
      final response = await apiService.login(loginRequestBody);

      return response;
    } catch (error) {
      log('Error: $error');
      final errorHandler = ApiErrorHandler.handle(error);
      log('errorHandler $errorHandler');
      throw ServerFailure(errorHandler);
    }
  }
}
