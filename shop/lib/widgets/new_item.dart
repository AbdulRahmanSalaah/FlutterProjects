import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;

import '../models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  final formKey = GlobalKey<FormState>();

  // Create variables to store the entered name, quantity, and category.
  var _enteredName = '';
  int _enteredQuantity = 0;
  // Initialize the selected category to the first category in the list.
  Category _selectedCategory = categories[Categories.fruit]!;

  bool _isLoading = false;

  void saveItem() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      final Uri url = Uri.https(
          'shop-d795a-default-rtdb.firebaseio.com', 'shopping-list.json');

      http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _selectedCategory.name,
        }),
      )
          .then((res) {
        if (res.statusCode >= 400) {
          throw Exception('Failed to add item');
        }
        Navigator.of(context).pop(
          GroceryItem(
            id: json.decode(res.body)['name'],
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),

          // form widget to create a form that will contain the input fields. The form widget will allow us to validate the input fields and save the data entered by the user.
          // The form widget requires a key to uniquely identify the form. We will use the formKey variable that we created earlier.
          // The form widget contains a child widget that is a Column widget. The Column widget allows us to arrange the input fields vertically.
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // TextFormField widget to create an input field for the name of the item. The TextFormField widget requires a decoration property to provide a label for the input field.
                TextFormField(
                  // onSaved property to save the value entered by the user when the form is saved.
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Name'),
                  maxLength: 50,
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      // TextFormField widget to create an input field for the quantity of the item. The TextFormField widget requires a decoration property to provide a label for the input field.
                      child: TextFormField(
                        // onSaved property to save the value entered by the user when the form is saved.
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                        decoration:
                            const InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Please enter a valid quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        // DropdownButtonFormField widget to create a dropdown list for the category of the item. The DropdownButtonFormField widget requires a value property to store the selected category.
                        child: DropdownButtonFormField(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Category'),
                      // items property to create a list of dropdown items. We will use the categories map to create the dropdown items.
                      // The categories map contains the list of categories that we imported earlier. We will loop through the categories map and create a dropdown item for each category.
                      items: [
                        for (var category in categories.entries)
                          // DropdownMenuItem widget to create a dropdown item. The DropdownMenuItem widget requires a value property to store the category and a child property to display the category name.
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  category.value.name,
                                )
                              ],
                            ),
                          )
                      ],
                      // onChanged property to update the selected category when the user selects a category from the dropdown list.
                      onChanged: (Category? value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      // Reset button to clear the input fields when the user clicks the Reset button.
                      // the formkey is used to reset the form.
                      onPressed: _isLoading
                          ? null
                          : () {
                              formKey.currentState!.reset();
                            },
                      child: const Text('Reset'),
                    ),
                    TextButton(
                        // Add Item button to add the item to the list when the user clicks the Add Item button.
                        // the formkey is used to validate the form and save the data entered by the user.
                        onPressed: _isLoading ? null : saveItem,
                        child: _isLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Add Item'))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
