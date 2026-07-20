import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends ChangeNotifier{

String selectedLanguage='en';
bool isLoggedIn = false;

late SharedPreferences _preferences ;

Future<void> init() async{
  _preferences = await SharedPreferences.getInstance();
  loadPrefs();
}

void loadPrefs()
{
  selectedLanguage = _preferences.getString("lang") ?? "en" ;

  isLoggedIn = _preferences.getBool("isLoggedIn")  ?? false;

  notifyListeners();

}
void setLang(String langCode)
{
  selectedLanguage =langCode;
  _preferences.setString("lang", langCode);
  notifyListeners();
}


void setIsLoggedIn(bool auth)
{
  isLoggedIn = auth;
  _preferences.setBool("isLoggedIn", auth);
  notifyListeners();

}










}
