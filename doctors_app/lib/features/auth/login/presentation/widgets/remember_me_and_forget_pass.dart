import 'package:flutter/material.dart';

import '../../../../../core/data/networking/api_constants.dart';
import '../../../../../core/theming/text_style.dart';

class RememberMeAndForgetPass extends StatefulWidget {
  const RememberMeAndForgetPass({super.key});

  @override
  State<RememberMeAndForgetPass> createState() =>
      _RememberMeAndForgetPassState();
}

class _RememberMeAndForgetPassState extends State<RememberMeAndForgetPass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            side: const BorderSide(
              color: Color(0xff757575),
              width: 1,
            ),

            checkColor: Colors.white,
            activeColor: Colors.blue,
            value: rememberMe,
            onChanged: (value) {
              setState(() {
                rememberMe = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.only(left: 0, top: 0),
            visualDensity: const VisualDensity(
              horizontal: -4,
            ), // Reduces space between checkbox and text

            title: Transform.translate(
              // Move the text closer to the checkbox
              offset: const Offset(-8, 0), // Adjusts horizontal space
              child: Text(
                "Remember Me",
                style: TextStyles.font13GreyRegular,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: TextStyles.font13BlueRegular,
          ),
        ),
      ],
    );
  }
}
