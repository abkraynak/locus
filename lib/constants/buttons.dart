import 'package:flutter/material.dart';

import 'colors.dart';
import 'positioning.dart';

class ElevatedButtons {
  static ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.secondary,
    shape: RoundedRectangleBorder(borderRadius: Radius.rounding),
    elevation: Elevations.level1,
  );
  static TextStyle mainTextStyle = TextStyle(
    color: ThemeColors.elevatedButtonText,
    fontSize: 22,
  );
}
