import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/watchlist_repo.dart';


class RemoveWatchlistItemUseCase extends BaseUseCase<Unit, int> {
  final WatchlistRepository _baseWatchListRepository;

  RemoveWatchlistItemUseCase(this._baseWatchListRepository);

  @override
  Future<Either<Failure, Unit>> call(int parameters) async {
    return await _baseWatchListRepository.removeWatchListItem(parameters);
  }
}
