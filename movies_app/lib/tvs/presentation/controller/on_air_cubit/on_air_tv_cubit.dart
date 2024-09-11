import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tvs/domain/usecases/get_now_playing_tv_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecases/base_use_case.dart';

part 'on_air_tv_state.dart';

class OnAirTvCubit extends Cubit<OnAirTvState> {
  OnAirTvCubit(this.getNowPlayingTvUsecase) : super(OnAirTvInitial());
  final GetOnAirTvUsecase getNowPlayingTvUsecase;

  void fetchOnAirTvShows() {
    emit(OnAirTvLoading());
    getNowPlayingTvUsecase.call(const NoParameters()).then((result) {
      result.fold(
        (failure) {
          emit(OnAirTvError(failure.message));
        },
        (tvShows) => emit(OnAirTvSuccess(tvShows)),
      );
    });
  }
}
