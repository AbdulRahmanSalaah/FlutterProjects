import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media_details.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/base_movie_repo.dart';



class GetMovieDetailsUsecase extends BaseUseCase<MediaDetails, int> {
  final BaseMovieRepo baseMoviesRepository;

  GetMovieDetailsUsecase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, MediaDetails>> call(int parameters) async {
    return await baseMoviesRepository.getMovieDetails(parameters);
  }
}
