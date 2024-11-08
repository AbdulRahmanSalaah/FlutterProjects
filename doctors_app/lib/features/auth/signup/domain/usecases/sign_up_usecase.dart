import 'package:dartz/dartz.dart';
import 'package:doctors_app/features/auth/signup/domain/repository/base_repo_sign_up.dart';

import '../../../../../core/data/error/failures.dart';
import '../../data/models/sign_up_request_body_model.dart';
import '../../data/models/sign_up_response_model.dart';

class SignUpUsecase {
  final BaseRepoSignUp baseRepoSignUp;

  SignUpUsecase({required this.baseRepoSignUp});

  Future<Either<Failure, SignUpResponse>> call(
      SignUpRequestBody signUpRequestBody) async {
    return await baseRepoSignUp.signUp(signUpRequestBody);
  }
}
