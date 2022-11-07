import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final dynamic controller;
  final bool? obscure;
  final String? errorText;
  final String? hintText;
  final dynamic validator;
  final dynamic onChanged;
  final double fontSize;
  final Widget? prefix;
  const CustomTextField(
      {Key? key,
      this.controller,
      this.obscure = false,
      this.validator,
      this.errorText,
      this.fontSize = 15.0,
      this.hintText,
      this.onChanged,
      this.prefix})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscure!,
      validator: validator ??
          (value) {
            if (value != null) {
              return errorText;
            } else {
              return null;
            }
          },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefix,
       // prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 50),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: const BorderSide(width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        contentPadding: const EdgeInsets.only(left: 21.0),
        hintText: hintText,
      ),
    );
  }
}
