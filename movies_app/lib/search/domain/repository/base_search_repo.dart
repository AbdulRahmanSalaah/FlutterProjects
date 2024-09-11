import 'package:dartz/dartz.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';

import '../../../core/data/error/failures.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
}
