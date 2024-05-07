// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
    this.controller,
    this.enabled,
    this.focusNode,
    this.validator,
    this.onSubmit,
    this.expands = false,
  });

  final String labelText;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool expands;
  Widget? suffixIcon;
  TextEditingController? controller;
  FocusNode? focusNode;
  bool? enabled;
  String? Function(String?)? validator;
  String? Function(String?)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      expands: expands,
      enabled: enabled,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      onTapOutside: (event) {
        KDeviceUtils.hideKeyboard(context);
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          floatingLabelStyle: const TextStyle().copyWith(
            fontSize: 22,
            color: Colors.black.withOpacity(0.8),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelMedium),
    );
  }
}
