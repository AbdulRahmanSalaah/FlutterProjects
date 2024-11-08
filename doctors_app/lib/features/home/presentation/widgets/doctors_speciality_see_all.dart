import 'package:flutter/material.dart';

import '../../../../core/theming/text_style.dart';

class DoctorsSpecialitySeeAll extends StatelessWidget {
  const DoctorsSpecialitySeeAll({super.key,  required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name ,
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            'See All',
            style: TextStyles.font12BlueRegular,
          ),
        ),
      ],
    );
  }
}
