import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';
import 'you_can_also_like_list.dart';

class UserMayLikeSection extends StatelessWidget {
  const UserMayLikeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'You can also like',
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: YouCanAlsoLikeList(),
        ),
      ],
    );
  }
}
