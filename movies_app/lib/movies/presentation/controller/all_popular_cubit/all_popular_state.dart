part of 'all_popular_cubit.dart';

sealed class AllPopularState extends Equatable {
  const AllPopularState();

  @override
  List<Object> get props => [];
}

final class AllPopularInitial extends AllPopularState {}

final class AllPopularLoading extends AllPopularState {}




final class AllPopularSuccess extends AllPopularState {
  final List<Media> movies;

  const AllPopularSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

final class AllPopularError extends AllPopularState {
  final String message;

  const AllPopularError(this.message);

  @override
  List<Object> get props => [message];
}
