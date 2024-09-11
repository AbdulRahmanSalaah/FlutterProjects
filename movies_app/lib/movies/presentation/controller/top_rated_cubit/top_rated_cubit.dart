import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecases/base_use_case.dart';
import '../../../domain/usecases/get_top_rated_movies_usecase.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit(this.getTopRatedMoviesUsecase) : super(TopRatedInitial());


  final GetTopRatedMoviesUsecase getTopRatedMoviesUsecase;


  void fetchTopRatedMovies() async {
    emit(TopRatedLoading());

    final result = await getTopRatedMoviesUsecase.call( const NoParameters());

    result.fold(
      (failure) => emit(TopRatedFailure(failure.message)),
      (movies) => emit(TopRatedSuccess(movies)),
    );
 
  }
}
