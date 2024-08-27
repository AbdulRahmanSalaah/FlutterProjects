import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../Features/home/data/repos/home_repo_impl.dart';
import '../../Features/search/data/repos/search_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Registering ApiService with Dio instance as a singleton object in the service locator container
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );

  // using the ApiService instance to register HomeRepoImpl as a singleton object in the service locator container
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt.get<ApiService>(),
    ),
  );

  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
}
