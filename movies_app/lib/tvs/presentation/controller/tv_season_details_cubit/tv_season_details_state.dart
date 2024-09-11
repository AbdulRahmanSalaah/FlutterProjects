part of 'tv_season_details_cubit.dart';

sealed class TvSeasonDetailsState extends Equatable {
  const TvSeasonDetailsState();

  @override
  List<Object> get props => [];
}

final class TvSeasonDetailsInitial extends TvSeasonDetailsState {}


final class TvSeasonDetailsLoading extends TvSeasonDetailsState {}


final class TvSeasonDetailsSuccess extends TvSeasonDetailsState {

  final SeasonDetails seasonDetails;

  const TvSeasonDetailsSuccess(this.seasonDetails);

  @override
  List<Object> get props => [seasonDetails];

}


final class TvSeasonDetailsError extends TvSeasonDetailsState {

  final String message;

  const TvSeasonDetailsError(this.message);

  @override
  List<Object> get props => [message];

}