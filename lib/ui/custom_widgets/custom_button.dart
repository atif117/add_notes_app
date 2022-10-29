import 'package:flutter/material.dart';
import 'package:notes_app/core/color.dart';

class CustomButton extends StatelessWidget {
  final String? labelText;
  final onTap;
  final Color? textColor;
  final Color? buttonColor;

  const CustomButton(
      {this.textColor = kWhiteColor,
      this.buttonColor = kBlackColor,
      this.labelText,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '$labelText',
            style: TextStyle(
                color: textColor!, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
