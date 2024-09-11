import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/usecases/base_use_case.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../repository/base_tv_repo.dart';

class GetAllTopRatedTvUsecase extends BaseUseCase<List<Media>, int> {
  final BaseTvRepo baseTvRepository;

  GetAllTopRatedTvUsecase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int parameters) async {
    return await baseTvRepository.getAllTopRatedTVShows(parameters);
  }
}
