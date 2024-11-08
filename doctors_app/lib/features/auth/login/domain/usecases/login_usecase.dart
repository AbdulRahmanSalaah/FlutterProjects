import 'package:dartz/dartz.dart';
import 'package:doctors_app/features/auth/login/domain/repository/base_repo_login.dart';

import '../../../../../core/data/error/failures.dart';
import '../../data/models/login_request_body_model.dart';
import '../../data/models/login_response_model.dart';

class LoginUseCase {
  final BaseRepoLogin baseRepoLogin;

  LoginUseCase({required this.baseRepoLogin});

  Future<Either<Failure, LoginResponse>> call(
      LoginRequestBody loginRequestBody) async {
    return  await baseRepoLogin.login(loginRequestBody);
  }
}
