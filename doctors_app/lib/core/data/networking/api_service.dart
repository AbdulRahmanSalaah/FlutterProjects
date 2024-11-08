import 'package:dio/dio.dart';
import 'package:doctors_app/features/auth/login/data/models/login_request_body_model.dart';
import 'package:doctors_app/features/auth/login/data/models/login_response_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/auth/signup/data/models/sign_up_request_body_model.dart';
import '../../../features/auth/signup/data/models/sign_up_response_model.dart';
import '../../../features/home/data/models/specializations_response_model.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBodyModel,
  );

  @POST(ApiConstants.signUp)
  Future<SignUpResponse> signUp(
    @Body() SignUpRequestBody signupRequestBodyModel,
  );

  @GET(ApiConstants.specializationEP)
  Future<SpecializationsResponseModel> getSpecializations();
}
