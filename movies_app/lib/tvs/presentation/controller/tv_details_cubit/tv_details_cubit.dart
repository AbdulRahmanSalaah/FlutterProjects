import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tvs/domain/usecases/get_tv_show_details_usecase.dart';

import '../../../../core/domain/entities/media_details.dart';

part 'tv_details_state.dart';

class TvDetailsCubit extends Cubit<TvDetailsState> {
  TvDetailsCubit(this.getTVShowDetailsUseCase) : super(TvDetailsInitial());

  final GetTVShowDetailsUseCase getTVShowDetailsUseCase;

  void fetchTVShowDetails(int id) async {
    emit(TvDetailsLoading());

    final result = await getTVShowDetailsUseCase(id);

    result.fold(
      (l) => emit(TvDetailsError(l.message)),
      (r) => emit(TvDetailsSuccess(r)),
    );
  }
}
