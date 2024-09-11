import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../domain/usecases/get_all_popular_tv_usecase.dart';

part 'all_popular_tv_state.dart';

class AllPopularTvCubit extends Cubit<AllPopularTvState> {
  AllPopularTvCubit(this.getAllPopularTvUsecase) : super(AllPopularTvInitial());

  final GetAllPopularTvUsecase getAllPopularTvUsecase;

  void fetchAllPopularTv() {
    emit(AllPopularTvLoading());
    getAllPopularTvUsecase.call(1).then((result) {
      result.fold(
        (failure) {
          emit(AllPopularTvError(failure.message));
        },
        (tvs) {
          emit(AllPopularTvSuccess(tvs));
        },
      );
    });
  }
}
