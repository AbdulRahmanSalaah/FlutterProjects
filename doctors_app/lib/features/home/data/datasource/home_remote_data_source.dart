import 'dart:developer';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/networking/api_error_handler.dart';
import '../../../../core/data/networking/api_service.dart';
import '../models/specializations_response_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<SpecializationsResponseModel> getSpecializations();
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource({required this.apiService});

  @override
  Future<SpecializationsResponseModel> getSpecializations() async {
    try {
      final response = await apiService.getSpecializations();

      return response;
    } catch (error) {
      log('Error: $error');
      final errorHandler = ApiErrorHandler.handle(error);
      log('errormessage $errorHandler');
      throw ServerFailure(errorHandler);
    }
  }
}
