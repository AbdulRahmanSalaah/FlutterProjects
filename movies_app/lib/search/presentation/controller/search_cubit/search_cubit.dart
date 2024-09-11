import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/search/domain/usecases/search_usecase.dart';

import '../../../domain/entities/search_result_item.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchUseCase) : super(SearchInitial());

  final SearchUseCase searchUseCase;

  void fetchSearchResults(String title) async {

    
    emit(const SearchLoading());
    final result = await searchUseCase(title);
    result.fold(
      (l) => emit(SearchFailure(l.message)),
      (r) {
        if (r.isEmpty) {
          emit(SearchNoResults());
        } else {
          emit(SearchSuccess(r));
        }
      },
    );
  }
}
