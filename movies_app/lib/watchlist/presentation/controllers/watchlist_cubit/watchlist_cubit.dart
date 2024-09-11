import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecases/base_use_case.dart';
import '../../../domain/usecases/check_if_item_added_usecase.dart';
import '../../../domain/usecases/get_watchlist_items_usecase.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit(this.addWatchListItemUseCase, this.removeWatchListItemUseCase,
      this.checkIfItemAddedUseCase, this.getWatchListItemsUseCase)
      : super(WatchlistInitial());

  final AddWatchlistItemUseCase addWatchListItemUseCase;
  final RemoveWatchlistItemUseCase removeWatchListItemUseCase;
  final CheckIfItemAddedUseCase checkIfItemAddedUseCase;
  final GetWatchlistItemsUseCase getWatchListItemsUseCase;

  Future<void> getWatchListItems() async {
    emit(WatchlistLoading());
    final result = await getWatchListItemsUseCase.call(const NoParameters());
    result.fold(
      (l) => emit(WatchlistError(l.message)),
      (r) {
        if (r.isEmpty) {
          emit(WatchlistEmpty());
        } else {
          emit(WatchlistSuccess(r));
        }
      },
    );
  }

  Future<void> addWatchListItem(Media item) async {
    emit(WatchlistLoading());

    final result = await addWatchListItemUseCase.call(item);
    result.fold(
      (l) => emit(WatchlistError(l.message)),
      (r) => emit(WatchlistItemAdded(item)),
    );
  }

  Future<void> removeWatchListItem(int index) async {
    emit(WatchlistLoading());

    final result = await removeWatchListItemUseCase.call(index);
    result.fold(
      (l) => emit(WatchlistError(l.message)),
      (r) => emit(WatchlistItemRemoved(index)),
    );
  }

  Future<void> checkIfItemAdded(int tmdbID) async {
    emit(WatchlistLoading());

    final result = await checkIfItemAddedUseCase.call(tmdbID);
    result.fold(
      (l) {
        emit(WatchlistError(l.message));
      },
      (r) {
        emit(WatchlistItemCheck(r));
      },
    );
  }
}
