part of 'popular_cubit.dart';

sealed class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

final class PopularInitial extends PopularState {}

final class PopularLoading extends PopularState {}

final class PopularFailure extends PopularState {
  final String errMessage;

  const PopularFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

final class PopularSuccess extends PopularState {
  final List<Media> movies;

  const PopularSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}


