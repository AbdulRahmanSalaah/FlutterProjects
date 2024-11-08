import 'package:dartz/dartz.dart';
import 'package:doctors_app/core/data/error/failures.dart';
import 'package:doctors_app/features/auth/signup/data/datasource/sign_up_remote_data_source.dart';
import 'package:doctors_app/features/auth/signup/data/models/sign_up_request_body_model.dart';
import 'package:doctors_app/features/auth/signup/data/models/sign_up_response_model.dart';
import 'package:doctors_app/features/auth/signup/domain/repository/base_repo_sign_up.dart';

import '../../../../../core/data/networking/api_error_handler.dart';

class SignUpRepoImpl extends BaseRepoSignUp {
  final BaseSignUpRemoteDataSource baseSignUpRemoteDataSource;

  SignUpRepoImpl({required this.baseSignUpRemoteDataSource});

  @override
  Future<Either<Failure, SignUpResponse>> signUp(
      SignUpRequestBody signUpRequestBody) async {
    try {
      final result = await baseSignUpRemoteDataSource.signUp(signUpRequestBody);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      final errorHandler = ApiErrorHandler.handle(error);
      return Left(ServerFailure(errorHandler));
    }
  }
}
