part of 'movie_detail_cubit.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}


final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {
  final MediaDetails movieDetails;

  const MovieDetailSuccess(this.movieDetails);

  @override
  List<Object> get props => [movieDetails];
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

