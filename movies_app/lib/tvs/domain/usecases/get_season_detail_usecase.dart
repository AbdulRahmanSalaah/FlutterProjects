import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/domain/usecases/base_use_case.dart';
import '../entities/season_details.dart';
import '../repository/base_tv_repo.dart';


class GetSeasonDetailsUseCase
    extends BaseUseCase<SeasonDetails, SeasonDetailsParams> {
  final BaseTvRepo _baseTVShowsRepository;

  GetSeasonDetailsUseCase(this._baseTVShowsRepository);
  @override
  Future<Either<Failure, SeasonDetails>> call(SeasonDetailsParams parameters) async {
    return await _baseTVShowsRepository.getSeasonDetails(parameters);
  }
}

class SeasonDetailsParams extends Equatable {
  final int id;
  final int seasonNumber;

  const SeasonDetailsParams({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
      ];
}
