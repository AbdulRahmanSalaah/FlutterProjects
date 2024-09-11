import 'package:movies_app/search/data/datasource/search_remote_data_source.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:dartz/dartz.dart';

import '../../../core/data/error/exeptions.dart';
import '../../../core/data/error/failures.dart';
import '../../domain/repository/base_search_repo.dart';

class SearchRepositoryImpl extends BaseSearchRepository {
  final BaseSearchRemoteDataSource _baseSearchRemoteDataSource;

  SearchRepositoryImpl(this._baseSearchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchResultItem>>> search(String title) async {
    try {
      final result = await _baseSearchRemoteDataSource.search(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } 
  }
}
