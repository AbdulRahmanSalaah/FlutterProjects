import 'package:dartz/dartz.dart';

import '../../../../../core/data/error/failures.dart';
import '../../data/models/sign_up_request_body_model.dart';
import '../../data/models/sign_up_response_model.dart';

abstract class BaseRepoSignUp {
  Future<Either<Failure, SignUpResponse>> signUp(
     SignUpRequestBody signUpRequestBody);
}
