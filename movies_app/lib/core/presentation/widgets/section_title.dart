import 'package:flutter/material.dart';

import 'package:movies_app/core/resources/app_values.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppPadding.p16,
        left: AppPadding.p16,
        top: AppPadding.p14,
        bottom: AppPadding.p14,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
