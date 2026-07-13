import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier{


  bool isDark = false;


  Color getColor(Color lightColor, Color darkColor) {
    return isDark ? darkColor : lightColor;
  }


  Color get getContainer => getColor(containerColor, darkContainerColor);


  Color getIconColor (){
    return getColor(iconColor, darkIconColor);
  }



  void changeTheme()
  {
    isDark = !isDark;
    notifyListeners();
  }










}