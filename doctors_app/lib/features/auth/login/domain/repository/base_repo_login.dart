import 'package:dartz/dartz.dart';
import 'package:doctors_app/core/data/error/failures.dart';

import '../../data/models/login_request_body_model.dart';
import '../../data/models/login_response_model.dart';

// request means the data that we are sending to the server
abstract class BaseRepoLogin {
  Future<Either<Failure, LoginResponse>> login(
      LoginRequestBody loginRequestBody);
}
