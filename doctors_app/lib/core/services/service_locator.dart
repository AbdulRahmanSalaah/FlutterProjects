import 'package:dio/dio.dart';
import 'package:doctors_app/features/auth/login/data/repository/login_repo_impl.dart';
import 'package:doctors_app/features/auth/login/domain/repository/base_repo_login.dart';
import 'package:doctors_app/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:doctors_app/features/auth/signup/data/datasource/sign_up_remote_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/login/data/datasource/login_remote_data_source.dart';
import '../../features/auth/signup/data/repository/sign_up_impl.dart';
import '../../features/auth/signup/domain/repository/base_repo_sign_up.dart';
import '../../features/auth/signup/domain/usecases/sign_up_usecase.dart';
import '../../features/home/data/datasource/home_remote_data_source.dart';
import '../../features/home/data/repository/home_repo_impl.dart';
import '../../features/home/domain/repository/base_home_repo.dart';
import '../../features/home/domain/usecases/get_specializations_usecase.dart';
import '../data/networking/api_service.dart';
import '../data/networking/dio_factory.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  // Dio  Instance for Network Call  (Api Service)
  Dio dio = DioFactory.getDio();

  // Api Service Instance for Network Call
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // For Auth......

  // DataSource
  getIt.registerLazySingleton<BaseLoginRemoteDataSource>(() {
    return LoginRemoteDataSource(apiService: getIt());
  });

  getIt.registerLazySingleton<BaseSignUpRemoteDataSource>(() {
    return SignUpRemoteDataSource(apiService: getIt());
  });

  // Repo
  getIt.registerLazySingleton<BaseRepoLogin>(() {
    return LoginRepoImpl(baseLoginRemoteDataSource: getIt());
  });

  getIt.registerLazySingleton<BaseRepoSignUp>(() {
    return SignUpRepoImpl(baseSignUpRemoteDataSource: getIt());
  });

  // usecase

  getIt.registerLazySingleton<LoginUseCase>(() {
    return LoginUseCase(baseRepoLogin: getIt());
  });

  getIt.registerLazySingleton<SignUpUsecase>(() {
    return SignUpUsecase(baseRepoSignUp: getIt());
  });

  //.........

  // For Home......

  // DataSource
  getIt.registerLazySingleton<BaseHomeRemoteDataSource>(() {
    return HomeRemoteDataSource(apiService: getIt());
  });

  // Repo

  getIt.registerLazySingleton<BaseHomeRepo>(() {
    return HomeRepoImpl(baseHomeRemoteDataSource: getIt());
  });

  // usecase

  getIt.registerLazySingleton<GetSpecializationsUsecase>(() {
    return GetSpecializationsUsecase(baseHomeRepo: getIt());
  });
}
