part of 'top_rated_tv_cubit.dart';

sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}


final class TopRatedTvLoading extends TopRatedTvState {}



final class TopRatedTvSuccess extends TopRatedTvState {
  final List<Media> topRatedTvShows;

  const TopRatedTvSuccess(this.topRatedTvShows);

  @override
  List<Object> get props => [topRatedTvShows];
}


final class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}


