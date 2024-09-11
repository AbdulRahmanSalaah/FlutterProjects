import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/watchlist_repo.dart';


class GetWatchlistItemsUseCase extends BaseUseCase<List<Media>, NoParameters> {
  final WatchlistRepository _baseWatchListRepository;

  GetWatchlistItemsUseCase(this._baseWatchListRepository);

  @override
  Future<Either<Failure, List<Media>>> call(NoParameters parameters) async {
    return await _baseWatchListRepository.getWatchListItems();
  }
}
