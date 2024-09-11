import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/domain/usecases/get_all_popular_usecase.dart';

import '../../../../core/domain/entities/media.dart';

part 'all_popular_state.dart';

class AllPopularCubit extends Cubit<AllPopularState> {
  AllPopularCubit(this.getAllPopularMoviesUseCase) : super(AllPopularInitial());

  final GetAllPopularMoviesUseCase getAllPopularMoviesUseCase;

  void fetchAllPopularMovies() {
    emit(AllPopularLoading());
    getAllPopularMoviesUseCase.call(1).then((result) {
      result.fold(
        (failure) {
          emit(AllPopularError(failure.message));
        },
        (movies) {
          emit(AllPopularSuccess(movies));
        },
      );
    });
  }
}
