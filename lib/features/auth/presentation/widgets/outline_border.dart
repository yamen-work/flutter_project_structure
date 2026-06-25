
import 'package:flutter/material.dart';

OutlineInputBorder outlineBorder({Color? borderColor}) {
  if (borderColor == null) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey[350]!, width: 1.5),
    );
  } else {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: borderColor),
    );
  }
}