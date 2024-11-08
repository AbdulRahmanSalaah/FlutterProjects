import 'dart:developer';

import '../../../../../core/data/error/failures.dart';
import '../../../../../core/data/networking/api_error_handler.dart';
import '../../../../../core/data/networking/api_service.dart';
import '../models/sign_up_request_body_model.dart';
import '../models/sign_up_response_model.dart';

abstract class BaseSignUpRemoteDataSource {
  Future<SignUpResponse> signUp(SignUpRequestBody signUpRequestBody);
}

class SignUpRemoteDataSource extends BaseSignUpRemoteDataSource {
  final ApiService apiService;

  SignUpRemoteDataSource({required this.apiService});

  @override
  Future<SignUpResponse> signUp(SignUpRequestBody signUpRequestBody) async {
    try {
      final response = await apiService.signUp(signUpRequestBody);

      return response;
    } catch (error) {
      log('Error: $error');
      final errorHandler = ApiErrorHandler.handle(error);
      log('errorHandler ${errorHandler.errors}');
      throw ServerFailure(errorHandler);
    }
  }
}
