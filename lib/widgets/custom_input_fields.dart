import 'package:flutter/material.dart';

class CustomInputFields extends StatelessWidget {
  const CustomInputFields({
    super.key,
    required this.onSaved,
    required this.regEx,
    required this.hintText,
    this.obscureText = false,
  });
  final Function(String?) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        // fontSize: 16,
      ),
      obscureText: obscureText,
      validator: (value) {
        return RegExp(regEx).hasMatch(value!)
            ? null
            : 'Please enter a valid value';
      },
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(30, 29, 37, 1),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        // enabledBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white54),
        // ),
        // focusedBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        // ),
      ),
    );
  }
}
