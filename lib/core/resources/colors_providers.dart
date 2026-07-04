import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';


class ColorNotifier with ChangeNotifier {


  bool isDark= false;


  Color _getColor(Color lightColor, Color darkColor) {
    return isDark ? darkColor : lightColor;
  }

  Color get getPrimaryColor => _getColor(appPrimaryColor,appPrimaryColor);
  Color get getBgColor => _getColor(bgColor, darkBgColor);

  Color get getBorderColor => _getColor(borderColor, darkBorderColor);
  Color get getIconColor => _getColor(iconColor, darkIconColor);

  Color get getContainer => _getColor(containerColor, darkContainerColor);

  Color get getTextColor => _getColor(textDark, textWhite);


  /// This will notify the listeners, which in turn updates the theme
  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();  // Notify listeners to rebuild with the updated theme
  }
}
