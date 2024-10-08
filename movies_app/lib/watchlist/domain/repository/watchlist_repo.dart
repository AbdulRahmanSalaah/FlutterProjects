import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';

import '../../../core/data/error/failures.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Media>>> getWatchListItems();
  Future<Either<Failure, int>> addWatchListItem(Media media);
  Future<Either<Failure, Unit>> removeWatchListItem(int index);
  Future<Either<Failure, int>> checkIfItemAdded(int tmdbId);
}
