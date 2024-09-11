import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/entities/media_details.dart';
import '../entities/season_details.dart';
import '../usecases/get_season_detail_usecase.dart';

abstract class BaseTvRepo {
  Future<Either<Failure, List<Media>>> getNowPlayingTv();
  Future<Either<Failure, List<Media>>> getPopularTv();
  Future<Either<Failure, List<Media>>> getTopRatedTv();
  Future<Either<Failure, MediaDetails>> getTVShowDetails(int id);
  Future<Either<Failure, SeasonDetails>> getSeasonDetails(
      SeasonDetailsParams params);
  Future<Either<Failure, List<Media>>> getAllPopularTVShows(int page);
  Future<Either<Failure, List<Media>>> getAllTopRatedTVShows(int page);
}
