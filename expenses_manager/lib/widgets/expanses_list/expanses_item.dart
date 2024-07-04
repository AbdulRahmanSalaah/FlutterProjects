import 'package:flutter/material.dart';

import '../../models/expanses_model.dart';

class ExpansesItem extends StatelessWidget {
  const ExpansesItem({super.key, required this.expanse});

  final ExpansesModel expanse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expanse.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '\$${expanse.amount.toStringAsFixed(2)}',
                ),

                // Spacer is a widget that takes up as much space as possible in a row or column
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expanse.category]),
                    const SizedBox(width: 4),
                    Text(expanse.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
