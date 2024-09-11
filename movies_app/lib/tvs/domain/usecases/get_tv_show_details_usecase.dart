import 'package:dartz/dartz.dart';
import 'package:movies_app/tvs/domain/repository/base_tv_repo.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/entities/media_details.dart';
import '../../../core/domain/usecases/base_use_case.dart';

class GetTVShowDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final BaseTvRepo baseTVShowsRepository;

  GetTVShowDetailsUseCase(this.baseTVShowsRepository);
  @override
  Future<Either<Failure, MediaDetails>> call(int parameters) async {
    return await baseTVShowsRepository.getTVShowDetails(parameters);
  }
}
