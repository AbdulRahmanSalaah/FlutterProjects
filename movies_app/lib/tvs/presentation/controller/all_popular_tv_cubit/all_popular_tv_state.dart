part of 'all_popular_tv_cubit.dart';

sealed class AllPopularTvState extends Equatable {
  const AllPopularTvState();

  @override
  List<Object> get props => [];
}

final class AllPopularTvInitial extends AllPopularTvState {}


final class AllPopularTvLoading extends AllPopularTvState {}


final class AllPopularTvSuccess extends AllPopularTvState {
  final List<Media> tvs;

  const AllPopularTvSuccess(this.tvs);

  @override
  List<Object> get props => [tvs];
}

final class AllPopularTvError extends AllPopularTvState {
  final String message;

  const AllPopularTvError(this.message);

  @override
  List<Object> get props => [message];
}