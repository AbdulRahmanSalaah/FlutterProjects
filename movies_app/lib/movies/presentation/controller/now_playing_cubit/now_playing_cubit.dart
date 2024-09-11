import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/domain/usecases/get_now_playing_movies_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecases/base_use_case.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit(this.getNowPlayingMoviesUsecase) : super(NowPlayingInitial());

  final GetNowPlayingMoviesUsecase getNowPlayingMoviesUsecase;

  void fetchNowPlayingMovies() async {
    emit(NowPlayingLoading());
    final result = await getNowPlayingMoviesUsecase.call( const NoParameters());
    result.fold(

      (failure) {
        log('NowPlayingCubit: fetchNowPlayingMovies: $failure');
        emit(NowPlayingFailure(failure.message));
      },
      (movies) => emit(NowPlayingSuccess(movies)),
    );
  }
}
