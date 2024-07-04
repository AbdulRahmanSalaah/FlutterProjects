import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expanses_model.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key, required this.addExpense});

  // The addExpense method is used to add a new expense to the list of expenses
  final void Function(ExpansesModel) addExpense;

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  // The selected date is stored in this variable
  DateTime? _selectedDate;
  // The formatter is used to format the date
  DateFormat formatter = DateFormat.yMd();

  // The controller is used to get the value of the text field when the button is pressed

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Category _selectedCategory = Category.leisure;

  // The dispose method is used to clean up the resources used by the controller
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.75,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                // The controller is used to get the value of the text field when the button is pressed
                controller: titleController,
                maxLength: 50,
                // The decoration is used to add a label to the text field
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        prefixText: '\$',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!).toString(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),

                          // async is used to make the function asynchronous (it can wait for the user to select a date before continuing to execute the next line of code)
                          onPressed: () async {
                            final now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 1, now.month, now.day);

                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: firstDate,
                                lastDate: now);

                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  // The dropdown button is used to select a category

                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (e) {
                      setState(() {
                        if (e == null) {
                          return;
                        }

                        setState(() {
                          _selectedCategory = e;
                        });
                      });
                    },
                  ),

                  // The Spacer widget is used to add space between the widgets
                  const Spacer(),

                  // create cancel button
                  TextButton(
                    // navigator.pop is used to close the modal bottom sheet when the cancel button is pressed
                    onPressed: () => Navigator.pop(context),
                    child: const Text('cancel'),
                  ),

                  // create add expense button , this button will add the expense to the list if the input is valid and close the modal bottom sheet
                  // else show an alert dialog to the user to enter a valid input
                  ElevatedButton(
                    onPressed: () {
                      final title = titleController.text;
                      final double? amount =
                          double.tryParse(amountController.text);

                      final bool isInvalidAmount =
                          amount == null || amount <= 0;

                      final date = _selectedDate;

                      if (title.trim().isEmpty ||
                          isInvalidAmount ||
                          date == null) {
                        // The showDialog method is used to show a dialog box with a title, content, and actions (buttons) to the user
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text('Invalid Input'),
                                  content: const Text(
                                      'Please make sure to enter a valid input'),
                                  actions: [
                                    TextButton(

                                        // navigator pop is used to close the dialog box when the okay button is pressed ,ctx  is used to get the context of the dialog box
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text('Ok'))
                                  ],
                                ));
                      } else {
                        widget.addExpense(ExpansesModel(
                          title: title,
                          amount: amount,
                          date: date,
                          category: _selectedCategory,
                        ));

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Expense'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
