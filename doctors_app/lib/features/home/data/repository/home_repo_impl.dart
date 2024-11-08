import 'package:dartz/dartz.dart';
import 'package:doctors_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctors_app/features/home/domain/repository/base_home_repo.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/data/networking/api_error_handler.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepoImpl extends BaseHomeRepo {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;

  HomeRepoImpl({required this.baseHomeRemoteDataSource});

  @override
  Future<Either<Failure, SpecializationsResponseModel>>
      getSpecializations() async {
    try {
      final result = await baseHomeRemoteDataSource.getSpecializations();
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      final errorHandler = ApiErrorHandler.handle(error);
      return Left(
          ServerFailure(errorHandler));
    }
  }
}
