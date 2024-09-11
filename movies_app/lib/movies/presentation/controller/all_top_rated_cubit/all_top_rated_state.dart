part of 'all_top_rated_cubit.dart';

sealed class AllTopRatedState extends Equatable {
  const AllTopRatedState();

  @override
  List<Object> get props => [];
}

final class AllTopRatedInitial extends AllTopRatedState {}

final class AllTopRatedLoading extends AllTopRatedState {}


final class AllTopRatedSuccess extends AllTopRatedState {
  final List<Media> movies;

  const AllTopRatedSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

final class AllTopRatedError extends AllTopRatedState {
  final String message;

  const AllTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

