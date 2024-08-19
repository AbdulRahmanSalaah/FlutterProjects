// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // title = json['title'];
    title = json['title']?.toString(); // Convert to String if necessary

    // note = json['note'];
    note = json['note']?.toString(); // Convert to String if necessary
    isCompleted = json['isCompleted'];
    // date = json['date'];
    date = json['date']?.toString(); // Convert to String if necessary
    // startTime = json['startTime'];
    startTime = json['startTime']?.toString(); // Convert to String if necessary
    // endTime = json['endTime'];
    endTime = json['endTime']?.toString(); // Convert to String if necessary
    color = json['color'];
    remind = json['remind'];
    // repeat = json['repeat'];
    repeat = json['repeat']?.toString(); // Convert to String if necessary
  }
}
