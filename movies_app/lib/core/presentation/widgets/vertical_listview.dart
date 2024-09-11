import 'package:flutter/material.dart';

import 'package:movies_app/core/resources/app_values.dart';

class VerticalListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {

    // A ListView.separated widget that displays a list of items with a separator.
    // separator means a widget that is displayed between each item in the list. 
    return ListView.separated(
      padding: const EdgeInsets.all(AppPadding.p8),
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (context, index) {
        return const SizedBox(height: AppSize.s10);
      },
    );
  }
}
