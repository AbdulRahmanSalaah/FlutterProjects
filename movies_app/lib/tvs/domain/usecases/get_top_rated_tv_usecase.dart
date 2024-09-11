import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../repository/base_tv_repo.dart';

class GetTopRatedTvUsecase extends BaseUseCase<List<Media>, NoParameters> {
  final BaseTvRepo baseTvRepository;

  GetTopRatedTvUsecase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<Media>>> call(NoParameters parameters) async {
    return await baseTvRepository.getTopRatedTv();
  }
}
