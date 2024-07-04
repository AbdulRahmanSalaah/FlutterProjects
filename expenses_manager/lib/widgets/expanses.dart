import 'package:expenses_manager/widgets/bottom.dart';
import 'package:flutter/material.dart';

// import 'models/expanses_model.dart';

import '../models/expanses_model.dart';
import 'chart/chart.dart';
import 'expanses_list/expanses_list.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() => _ExpansesState();
}

class _ExpansesState extends State<Expanses> {
  // The list of expenses is stored in this variable
  final List<ExpansesModel> _registeredExpenses = [
    ExpansesModel(
      category: Category.work,
      title: 'Flutter Course',
      amount: 29.888888888888,
      date: DateTime.now(),
    ),
    ExpansesModel(
      category: Category.leisure,
      title: 'Cinema',
      amount: 9.71,
      date: DateTime.now(),
    ),
    ExpansesModel(
      category: Category.food,
      title: 'Breakfast',
      amount: 31.3,
      date: DateTime.now(),
    ),
  ];

  // The addExpense method is used to add a new expense to the list of expenses
  void addExpense(ExpansesModel expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // The removeExpense method is used to remove an expense from the list of expenses
  void removeExpense(ExpansesModel expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    // The width variable is used to get the width of the screen of the device
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpensesTracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // The showModalBottomSheet method is used to display a modal bottom sheet in the UI
              showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (c) => Bottom(
                        addExpense: addExpense,
                      ));
            },
          )
        ],
      ),
      body: Center(
          child: width < 600
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chart(
                      expenses: _registeredExpenses,
                    ),
                    Expanded(
                      // The ExpansesList widget is used to display the list of expenses
                      child: ExpansesList(
                        expenses: _registeredExpenses,
                        removeExpense: removeExpense,
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Chart(
                        expenses: _registeredExpenses,
                      ),
                    ),
                    Expanded(
                      // The ExpansesList widget is used to display the list of expenses
                      child: ExpansesList(
                        expenses: _registeredExpenses,
                        removeExpense: removeExpense,
                      ),
                    )
                  ],
                )),
    );
  }
}
