import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/media_details.dart';
import '../../../domain/usecases/get_movie_details_usecase.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this.getMovieDetailsUsecase) : super(MovieDetailInitial());

  final GetMovieDetailsUsecase getMovieDetailsUsecase;

  void fetchMovieDetails(int movieId) {
    emit(MovieDetailLoading());
    getMovieDetailsUsecase.call(movieId).then((result) {
      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movieDetails) {
          emit(MovieDetailSuccess(movieDetails));
        },
      );
    });
  }
}
