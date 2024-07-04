import 'package:flutter/material.dart';

// for the date format
import 'package:intl/intl.dart';

// for the unique id
import 'package:uuid/uuid.dart';




const uuid = Uuid(); // Create a Uuid objectc  to generate unique id

final DateFormat dateFormat = DateFormat.yMd();

enum Category { food, travel, leisure, work }

final categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpansesModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Category category;

  String get formattedDate => dateFormat.format(date);

  ExpansesModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
}

class ExpensesBucket {
  final Category category;
  final List<ExpansesModel> expenses;

  ExpensesBucket(this.category, this.expenses);

  ExpensesBucket.forCategory(List<ExpansesModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
