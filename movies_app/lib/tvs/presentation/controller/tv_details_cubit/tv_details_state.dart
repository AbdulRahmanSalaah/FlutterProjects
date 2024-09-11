part of 'tv_details_cubit.dart';

sealed class TvDetailsState extends Equatable {
  const TvDetailsState();

  @override
  List<Object> get props => [];
}

final class TvDetailsInitial extends TvDetailsState {}

final class TvDetailsLoading extends TvDetailsState {}


final class TvDetailsSuccess extends TvDetailsState {

  final MediaDetails tvShowDetails;

  const TvDetailsSuccess(this.tvShowDetails);

  @override
  List<Object> get props => [tvShowDetails];

}

final class TvDetailsError extends TvDetailsState {

  final String message;

  const TvDetailsError(this.message);

  @override
  List<Object> get props => [message];

}


