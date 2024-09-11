import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/watchlist_repo.dart';

class AddWatchlistItemUseCase extends BaseUseCase<int, Media> {
  final WatchlistRepository _baseWatchListRepository;

  AddWatchlistItemUseCase(this._baseWatchListRepository);

  @override
  Future<Either<Failure, int>> call(Media parameters) async {
    return await _baseWatchListRepository.addWatchListItem(parameters);
  }
}
