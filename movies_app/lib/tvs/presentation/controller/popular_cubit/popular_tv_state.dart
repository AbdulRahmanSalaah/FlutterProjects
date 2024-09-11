part of 'popular_tv_cubit.dart';

sealed class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

final class PopularTvInitial extends PopularTvState {}



final class PopularTvLoading extends PopularTvState {}

final class PopularTvSuccess extends PopularTvState {
  final List<Media> popularTvShows;

  const PopularTvSuccess(this.popularTvShows);

  @override
  List<Object> get props => [popularTvShows];
}

final class PopularTvError extends PopularTvState {
  final String message;

  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}