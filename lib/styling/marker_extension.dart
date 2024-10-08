import 'package:flutter/material.dart';

extension MarkerExtension on int {
  String toDisplayValue() {
    if (this < 0 || this > 1) {
      return '-';
    }
    if (this == 0) {
      return 'O';
    }
    return 'X';
  }

  Color toColor(ThemeData theme) {
    if (this == 0) {
      return theme.colorScheme.primary;
    }
    return theme.colorScheme.secondaryFixed;
  }
}
