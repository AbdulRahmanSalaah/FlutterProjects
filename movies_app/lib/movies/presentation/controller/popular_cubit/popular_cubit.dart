import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/domain/usecases/get_popular_movies_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecases/base_use_case.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit(this.getPopularMoviesUseCase) : super(PopularInitial());


  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  void fetchPopularMovies() async {
    emit(PopularLoading());

    final result = await getPopularMoviesUseCase.call( const NoParameters());

    result.fold(
      (failure) => emit(PopularFailure(failure.message)),
      (movies) => emit(PopularSuccess(movies)),
    );
    

  }
}
