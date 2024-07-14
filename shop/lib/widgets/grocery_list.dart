import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/data/categories.dart';

import '../models/category.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> myItems = [];
  bool isLoading = true;
  String? error;

  void _loadData() async {
    final Uri url = Uri.https(
        'shop-d795a-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final res = await http.get(url);

      if (res.statusCode >= 400) {
        setState(() {
          error = 'Failed to load data';
        });
        return;
      }

      if (res.body == 'null') {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> data = json.decode(res.body);

      final List<GroceryItem> loadedItems = [];

      for (var item in data.entries) {
        // find the category of the item from the categories list using the category name from the item data
        final Category category = categories.entries
            .firstWhere(
              (element) => element.value.name == item.value['category'],
            )
            .value;

        // add the item to the loadedItems list

        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
        setState(() {
          myItems = loadedItems;
          isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        error = 'Something went wrong Please try again later';
      });
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No item added yet!'),
    );

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (myItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: myItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(myItems[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              removeItem(myItems[index]);
            },
            child: ListTile(
              title: Text(myItems[index].name),

              // trailing is the right side of the list tile
              trailing: Text(myItems[index].quantity.toString()),

              // leading is the left side of the list tile
              leading: Container(
                width: 20,
                height: 20,
                color: myItems[index].category.color,
              ),
            ),
          );
        },
      );
    }
    if (error != null) {
      content = Center(
        child: Text(error!),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery '),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addItem,
          ),
        ],
      ),
      body: content,
    );
  }

  void removeItem(GroceryItem item) async {
    final index = myItems.indexOf(item);

    setState(() {
      myItems.remove(item);
    });
    final Uri url = Uri.https('shop-d795a-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final res = await http.delete(url);

    if (res.statusCode >= 400) {
      setState(() {
        myItems.insert(index, item);
      });
      throw Exception('Failed to delete item');
    }
  }

  void addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      myItems.add(newItem);
    });
  }
}
