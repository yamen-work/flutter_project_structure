import 'package:country_flags/country_flags.dart';
import 'package:exercise_projects/Localization/l10n/app_localization.dart';
import 'package:exercise_projects/core/widgets/restart_widget.dart';
import 'package:flutter/material.dart';

import '../resources/colors_and_styles.dart';

class CustomDrawer extends StatelessWidget {


  CustomDrawer({super.key});

  final GlobalKey _chooseLanguageKey = GlobalKey();


 void changeLanguage(String code)async{
    // SharedPreferences sharedPreferences =
    // await SharedPreferences.getInstance();
    // await sharedPreferences.setString(
    //     'localization', code);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.shade200,
      ),
      child: Column(
        children: [
          Image.asset("assets/images/tamkeen_logo.jpg",fit: BoxFit.cover ,height: 250,width: double.maxFinite,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              key: _chooseLanguageKey,
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context)!.chooseLanguage,
                textAlign: TextAlign.center,
                style: mediumTextStyle.copyWith(color: Colors.white),
              ),
              onTap: () {
                final RenderBox renderBox = _chooseLanguageKey.currentContext!
                    .findRenderObject() as RenderBox;
                final position = renderBox.localToGlobal(Offset.zero);

                showMenu(
                    context: context,
                    color: Colors.white,
                    position: RelativeRect.fromLTRB(
                        position.dx, position.dy, position.dx, position.dy),
                    items: [
                      PopupMenuItem<String>(
                        value: 'العربية',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: (){
                              // changeLanguage("ar");
                              RestartWidget.restartApp(context);

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blueGrey,),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child:
                                    CountryFlag.fromCountryCode("SA",theme: ImageTheme()),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                      child: Text(
                                        "العربية",
                                        style: mediumTextStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'English',
                        child: InkWell(
                          onTap: () {
                            // changeLanguage("en");
                            RestartWidget.restartApp(context);

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blueGrey,),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child:
                                  CountryFlag.fromCountryCode("USA",theme: ImageTheme()),
                                ),
                              ),
                              Expanded(
                                flex:2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Center(
                                    child: Text(
                                      "English",
                                      style: mediumTextStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
