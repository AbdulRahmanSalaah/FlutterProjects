import 'package:shop/models/category.dart';

class GroceryItem {
  final String id;
  final String name;
  final Category category;
  final int quantity;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
  });

  // factory GroceryItem.fromMap(Map<String, dynamic> data, String documentId) {
  //   final String name = data['name'];
  //   final String category = data['category'];
  //   final String quantity = data['quantity'];
  //   final String note = data['note'];
  //   final bool isComplete = data['isComplete'];

  //   return GroceryItem(
  //     id: documentId,
  //     name: name,
  //     category: category,
  //     quantity: quantity,
  //     note: note,
  //     isComplete: isComplete,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     'category': category,
  //     'quantity': quantity,
  //     'note': note,
  //     'isComplete': isComplete,
  //   };
  // }
}
