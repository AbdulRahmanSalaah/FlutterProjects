import 'package:dartz/dartz.dart';
import 'package:movies_app/core/data/error/failures.dart';

import '../../../core/domain/entities/media.dart';
import '../../../core/domain/entities/media_details.dart';


abstract class BaseMovieRepo {
  Future<Either<Failure, List<Media>>> getNowPlayingMovies();
  Future<Either<Failure, List<Media>>> getPopularMovies();
  Future<Either<Failure, List<Media>>> getTopRatedMovies();

  Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId);
  Future<Either<Failure, List<Media>>> getAllPopularMovies(int page);
  Future<Either<Failure, List<Media>>> getAllTopRatedMovies(int page);

}
