import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/usecases/base_use_case.dart';
import 'package:movies_app/tvs/domain/usecases/get_top_rated_tv_usecase.dart';

import '../../../../core/domain/entities/media.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  TopRatedTvCubit(this.getTopRatedTvUsecase) : super(TopRatedTvInitial());

  final GetTopRatedTvUsecase getTopRatedTvUsecase;

  void fetchTopRatedTvShows() async {
    emit(TopRatedTvLoading());
    final result = await getTopRatedTvUsecase.call(const NoParameters());
    result.fold(
      (l) => emit(TopRatedTvError(l.message)),
      (r) => emit(TopRatedTvSuccess(r)),
    );
  }
}
