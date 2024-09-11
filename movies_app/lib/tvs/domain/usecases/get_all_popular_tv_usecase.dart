import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/base_tv_repo.dart';

class GetAllPopularTvUsecase extends BaseUseCase<List<Media>, int> {
  final BaseTvRepo baseTvRepository;

  GetAllPopularTvUsecase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int parameters) async {
    return await baseTvRepository.getAllPopularTVShows(parameters);
  }
}
