import 'package:dartz/dartz.dart';

import 'package:doctors_app/core/data/error/failures.dart';

import '../../../../../core/data/networking/api_error_handler.dart';
import '../../domain/repository/base_repo_login.dart';
import '../datasource/login_remote_data_source.dart';
import '../models/login_request_body_model.dart';
import '../models/login_response_model.dart';

class LoginRepoImpl implements BaseRepoLogin {
  final BaseLoginRemoteDataSource baseLoginRemoteDataSource;

  LoginRepoImpl({required this.baseLoginRemoteDataSource});
  @override
  Future<Either<Failure, LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final result = await baseLoginRemoteDataSource.login(loginRequestBody);

      return Right(result);
    } on Failure catch (failure) {
      // Catch and return the failure directly
      return Left(failure); // Failure case
    } catch (error) {
      // If any other unknown error happens, catch and handle it
      final errorHandler = ApiErrorHandler.handle(error);
      return Left(ServerFailure(errorHandler));
    }
  }
}
