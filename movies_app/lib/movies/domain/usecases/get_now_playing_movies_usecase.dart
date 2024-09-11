import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/base_movie_repo.dart';

class GetNowPlayingMoviesUsecase
    extends BaseUseCase<List<Media>, NoParameters> {
  final BaseMovieRepo baseMoviesRepository;

  GetNowPlayingMoviesUsecase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Media>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getNowPlayingMovies();
  }
}
