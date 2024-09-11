part of 'watchlist_cubit.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistEmpty extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {}



final class WatchlistSuccess extends WatchlistState {
  final List<Media> items;

  const WatchlistSuccess(this.items);

  @override
  List<Object> get props => [items];
}


final class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}


final class WatchlistItemAdded extends WatchlistState {
  final Media item;

  const WatchlistItemAdded(this.item);

  @override
  List<Object> get props => [item];
}


final class WatchlistItemRemoved extends WatchlistState {
  final int index;

 
  const WatchlistItemRemoved(this.index);

  @override
  List<Object> get props => [index];
}


final class WatchlistItemCheck extends WatchlistState {
  final int tmdbId;

  const WatchlistItemCheck(this.tmdbId);

  @override
  List<Object> get props => [tmdbId];

  int? get id => null;
}



