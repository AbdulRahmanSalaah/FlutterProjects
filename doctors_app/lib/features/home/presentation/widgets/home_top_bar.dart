import 'package:doctors_app/core/data/networking/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_style.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});



  @override
  Widget build(BuildContext context) {


    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $userNametohome!',
              style: TextStyles.font18DarkBlueBold,
            ),
            Text(
              'How Are you Today?',
              style: TextStyles.font12GrayRegular,
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 24.0,
          backgroundColor: AppColors.moreLighterGray,
          child: SvgPicture.asset(
            'assets/svgs/notifications.svg',
          ),
        )
      ],
    );
  }
  }
