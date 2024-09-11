part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {
  const SearchLoading();

  @override
  List<Object> get props => [];
}



final class SearchSuccess extends SearchState {
  final List<SearchResultItem> searchResults;

  const SearchSuccess(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}




final class SearchFailure extends SearchState {
  final String message;

  const SearchFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchNoResults extends SearchState {}