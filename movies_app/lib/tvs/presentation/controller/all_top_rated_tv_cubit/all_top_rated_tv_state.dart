part of 'all_top_rated_tv_cubit.dart';

sealed class AllTopRatedTvState extends Equatable {
  const AllTopRatedTvState();

  @override
  List<Object> get props => [];
}

final class AllTopRatedTvInitial extends AllTopRatedTvState {}


final class AllTopRatedTvLoading extends AllTopRatedTvState {}


final class AllTopRatedTvSuccess extends AllTopRatedTvState {
  final List<Media> tvs;

  const AllTopRatedTvSuccess(this.tvs);

  @override
  List<Object> get props => [tvs];
}

final class AllTopRatedTvError extends AllTopRatedTvState {
  final String message;

  const AllTopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}
