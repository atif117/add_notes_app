import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final IconData? icon;
  bool obscureText;
  final onChanged;
  final validate;

  CustomTextField(
      {this.onChanged,
      this.validate,
      this.icon,
      this.obscureText = false,
      this.labelText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: onChanged,
          validator: validate,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text('$labelText'),
              suffixIcon: Icon(icon)),
          obscureText: obscureText,
        ),
        const SizedBox(
          height: 35,
        )
      ],
    );
  }
}
