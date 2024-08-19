import 'package:flutter/material.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    required this.hint,
    this.widget,
    this.controller,
  });

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            // the readonly means that the textfield is not editable  and the value is set to true if the widget is null
            readOnly: widget == null ? false : true,
            controller: controller,
            style: subTitleStyle,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: subTitleStyle,
              suffixIcon: widget,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
