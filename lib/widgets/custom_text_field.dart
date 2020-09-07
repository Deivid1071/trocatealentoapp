import 'package:flutter/material.dart';
import 'package:trocatalentos_app/utilities/constants.dart';

class CustomTextField extends StatelessWidget {

  CustomTextField({this.hint, this.prefix, this.suffix, this.obscure = false,
    this.textInputType, this.onChanged, this.enabled, this.controller
  });

  final TextEditingController controller;
  final String hint;
  final Widget prefix;
  final Widget suffix;
  final bool obscure;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      padding: prefix != null ? null : const EdgeInsets.only(left: 16),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Nunito',
        ),
        obscureText: obscure,
        keyboardType: textInputType,
        onChanged: onChanged,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: kHintTextStyle,
          border: InputBorder.none,
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
