import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/models/book_model/book_model.dart';
import '../../../../data/repos/search_repo.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.searchRepo) : super(SearchBooksInitial());

  final SearchRepo searchRepo;

  Future<void> fetchSearchBooks({required String query}) async {
    emit(SearchBooksLoading());
    var result = await searchRepo.fetchSearchBook(query: query);
    result.fold((failure) {
      emit(SearchBooksError(failure.errMessage));
    }, (books) {
      emit(SearchBooksSuccess(books));
    });
  }
}
