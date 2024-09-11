import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tvs/domain/usecases/get_popular_tv_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecases/base_use_case.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  PopularTvCubit(this.getPopularTvUsecase) : super(PopularTvInitial());

  final GetPopularTvUsecase getPopularTvUsecase;

  void fetchPopularTvShows() {
    emit(PopularTvLoading());
    getPopularTvUsecase.call(const NoParameters()).then((result) {
      result.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (tvShows) => emit(PopularTvSuccess(tvShows)),
      );
    });
  }
}
