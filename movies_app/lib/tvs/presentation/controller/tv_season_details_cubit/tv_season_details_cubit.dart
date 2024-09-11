import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/season_details.dart';
import '../../../domain/usecases/get_season_detail_usecase.dart';

part 'tv_season_details_state.dart';

class TvSeasonDetailsCubit extends Cubit<TvSeasonDetailsState> {
  TvSeasonDetailsCubit(this.getSeasonDetailsUseCase)
      : super(TvSeasonDetailsInitial());

  final GetSeasonDetailsUseCase getSeasonDetailsUseCase;

  void fetchSeasonDetails(int id, int seasonNumber) async {
    emit(TvSeasonDetailsLoading());

    final result = await getSeasonDetailsUseCase(
      SeasonDetailsParams(
        id: id,
        seasonNumber: seasonNumber,
      ),
    );

    result.fold(
      (l) => emit(TvSeasonDetailsError(l.message)),
      (r) => emit(TvSeasonDetailsSuccess(r)),
    );
  }
}
