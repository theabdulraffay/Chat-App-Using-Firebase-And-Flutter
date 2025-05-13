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

class CustomTextField extends StatelessWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;

  CustomTextField({
    super.key,
    required this.onEditingComplete,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () => onEditingComplete(controller.value.text),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(30, 29, 37, 1.0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
      ),
    );
  }
}
