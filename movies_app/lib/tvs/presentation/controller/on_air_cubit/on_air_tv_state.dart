part of 'on_air_tv_cubit.dart';

sealed class OnAirTvState extends Equatable {
  const OnAirTvState();

  @override
  List<Object> get props => [];
}

final class OnAirTvInitial extends OnAirTvState {}

final class OnAirTvLoading extends OnAirTvState {}

final class OnAirTvSuccess extends OnAirTvState {
  final List<Media> onAirTvShows;

  const OnAirTvSuccess(this.onAirTvShows);

  @override
  List<Object> get props => [onAirTvShows];
}

final class OnAirTvError extends OnAirTvState {
  final String message;

  const OnAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

