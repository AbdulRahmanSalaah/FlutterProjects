import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';

abstract class BaseWatchlistLocalDataSource {
  Future<List<WatchlistItemModel>> getWatchListItems();
  Future<int> addWatchListItem(WatchlistItemModel item);
  Future<void> removeWatchListItem(int index);
  Future<int> isItemAdded(int tmdbID);
}

class WatchlistLocalDataSourceImpl extends BaseWatchlistLocalDataSource {
  final Box _box = Hive.box('items');

  @override
  Future<List<WatchlistItemModel>> getWatchListItems() async {
    return _box.values
        .map((e) => WatchlistItemModel.fromEntity(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<int> addWatchListItem(WatchlistItemModel item) async {
    return await _box.add(item);
  }

@override
Future<void> removeWatchListItem(int index) async {
  log('removeWatchListItem index: $index');
  
  try {
    // Attempt to remove by the provided index directly
    await _box.deleteAt(index);
  } catch (e) {
    log('Failed to remove item at index $index: $e');
    
    // Find the index based on the tmdbID
    final newindex = _box.values.toList().indexWhere((item) => item.tmdbID == index);
    
    if (newindex != -1) {
      // Remove the item by its found index
      await _box.deleteAt(newindex);
      log('Successfully removed item at new index: $newindex');
    } else {
      log('Item with tmdbID $index not found in watchlist');
    }
  }
}


  @override
  Future<int> isItemAdded(int tmdbID) async {
    log('isItemAdded tmdbID: $tmdbID');
    log(_box.values.toList().indexWhere((e) => e.tmdbID == tmdbID).toString());
    // these return the index of the item in the box if it exists or -1 if it doesn't
    return _box.values.toList().indexWhere((e) => e.tmdbID == tmdbID);
  }
}
