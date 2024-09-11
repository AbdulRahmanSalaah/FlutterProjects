part of 'top_rated_cubit.dart';

sealed class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

final class TopRatedInitial extends TopRatedState {}

final class TopRatedLoading extends TopRatedState {}

final class TopRatedFailure extends TopRatedState {
  final String errMessage;

  const TopRatedFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}



final class TopRatedSuccess extends TopRatedState {
  final List<Media> movies;

  const TopRatedSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}