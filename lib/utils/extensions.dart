import 'package:flutter/material.dart';

extension MySize on int {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
  Divider get div => Divider(thickness: toDouble());
}

extension MyText on String {
  Text ts({TextStyle? style}) => Text(this, style: style);

  // TextFormField tff({
  //   TextStyle? style,
  //   InputDecoration? decoration,
  //   TextInputType? keyboardType,
  //   TextInputAction? textInputAction,
  //   bool obscureText = false,
  //   FormFieldValidator<String>? validator,
  //   FormFieldSetter<String>? onSaved,
  //   ValueChanged<String>? onChanged,
  // }) =>
  //     TextFormField(
  //       initialValue: this,
  //       style: style,
  //       decoration: decoration,
  //       keyboardType: keyboardType,
  //       textInputAction: textInputAction,
  //       obscureText: obscureText,
  //       validator: validator,
  //       onSaved: onSaved,
  //       onChanged: onChanged,
  //     );
}
