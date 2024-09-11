import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../domain/usecases/get_all_top_rated_tv_usecase.dart';

part 'all_top_rated_tv_state.dart';

class AllTopRatedTvCubit extends Cubit<AllTopRatedTvState> {
  AllTopRatedTvCubit(this.getAllTopRateTvsUseCase)
      : super(AllTopRatedTvInitial());

  final GetAllTopRatedTvUsecase getAllTopRateTvsUseCase;

  void fetchAllTopRatedTv() {
    emit(AllTopRatedTvLoading());
    getAllTopRateTvsUseCase.call(1).then((result) {
      result.fold(
        (failure) {
          emit(AllTopRatedTvError(failure.message));
        },
        (tvs) {
          emit(AllTopRatedTvSuccess(tvs));
        },
      );
    });
  }
}
