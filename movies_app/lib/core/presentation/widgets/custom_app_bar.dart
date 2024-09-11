import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/app_values.dart';

class CustomAppBar extends StatelessWidget  {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;



  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title),
      leading: context.canPop()
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppSize.s20,
                color:  Colors.white,
              ),
            )
          : null,
    );
  }
}
