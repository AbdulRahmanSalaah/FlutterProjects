import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'history_hive_model.g.dart';

// random id

final rid = const Uuid().v4();

@HiveType(typeId: 0)
class HistoryModelHive {
  HistoryModelHive({
    required this.playerXName,
    required this.playerOName,
    required this.winner,
    DateTime? date,
    String? id,
  }) : date = date ?? DateTime.now() {
    id = id ?? rid;
  }

  @HiveField(1)
  String playerXName;
  @HiveField(2)
  String playerOName;
  @HiveField(3)
  String? winner;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String id = rid;

  //  this is a method that returns a string representation of the object
  @override
  String toString() {
    return 'HistoryModelHive{playerXName: $playerXName, playerOName: $playerOName, winner: $winner, date: $date}';
  }
}
