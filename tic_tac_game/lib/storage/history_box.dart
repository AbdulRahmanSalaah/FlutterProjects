import 'package:hive/hive.dart';

import '../model/history_hive_model.dart';

class HistoryBox {
  static const String historyBox = 'history_box';

  static Future<void> openBox() async {
    await Hive.openBox<HistoryModelHive>(historyBox);
  }

  static Box<HistoryModelHive> getHistoryBox() {
    final box = Hive.box<HistoryModelHive>(historyBox);
    return box;
  }

  static void setHistory(HistoryModelHive history) {
    final historyBox = getHistoryBox();
    historyBox.add(history);
  }

  static List<HistoryModelHive> getHistory() {
    final historyBox = getHistoryBox();
    final List<HistoryModelHive> historyList = historyBox.values.toList();
    return historyList;
  }

  // Add this method to delete a history entry by index
  static void deleteHistory(HistoryModelHive item) {
    final historyBox = getHistoryBox();

    final index = historyBox.values.toList().indexOf(item);
    historyBox.deleteAt(index); // Use index for deletion
  }
}
