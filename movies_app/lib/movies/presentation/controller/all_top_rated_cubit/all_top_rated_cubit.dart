import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../domain/usecases/get_all_top_rated_usecase.dart';

part 'all_top_rated_state.dart';

class AllTopRatedCubit extends Cubit<AllTopRatedState> {
  AllTopRatedCubit(this.getAllTopRatedMoviesUseCase)
      : super(AllTopRatedInitial());

  final GetAllTopRatedMoviesUseCase getAllTopRatedMoviesUseCase;

  void fetchAllTopRatedMovies() {
    emit(AllTopRatedLoading());
    // call 1 for the first page  of top rated movies
    getAllTopRatedMoviesUseCase.call(1).then(
      (result) {
        result.fold(
          (failure) {
            emit(AllTopRatedError(failure.message));
          },
          (movies) {
            emit(AllTopRatedSuccess(movies));
          },
        );
      },
    );
  }
}
