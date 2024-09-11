import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../entities/search_result_item.dart';
import '../repository/base_search_repo.dart';

class SearchUseCase extends BaseUseCase<List<SearchResultItem>, String> {
  final BaseSearchRepository _baseSearchRepository;

  SearchUseCase(this._baseSearchRepository);

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(
      String parameters) async {
    return await _baseSearchRepository.search(parameters);
  }
}
