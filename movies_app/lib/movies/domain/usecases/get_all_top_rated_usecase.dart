

import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/base_movie_repo.dart';

class GetAllTopRatedMoviesUseCase extends BaseUseCase<List<Media>, int> {
  final BaseMovieRepo _baseMoviesRespository;

  GetAllTopRatedMoviesUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, List<Media>>> call(int parameters) async {
    return await _baseMoviesRespository.getAllTopRatedMovies(parameters);
  }
}
