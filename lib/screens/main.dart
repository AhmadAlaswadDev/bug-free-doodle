// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'dart:io';

import 'package:ammanauto/custom/common_functions.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/presenter/bottom_appbar_index.dart';
import 'package:ammanauto/screens/clubs.dart';
import 'package:ammanauto/screens/guest.dart';
import 'package:ammanauto/screens/home.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/screens/offers.dart';
import 'package:ammanauto/screens/registration.dart';
import 'package:ammanauto/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_transitions/route_transitions.dart';

class Main extends StatefulWidget {
  late bool go_back;
  // ignore: non_constant_identifier_names
  Main({bool  go_back = true}) : super();


  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  //int _cartCount = 0;

  BottomAppbarIndex bottomAppbarIndex = BottomAppbarIndex();

  var _children = [];

  fetchAll(){


  }

  void onTapped(int i) {
    fetchAll();

    if(i == 1){

    }
    if(i == 2){
      
    }
    if(i == 3){
      
    }


    setState(() {
      _currentIndex = i;
    });

    // if (!is_logged_in.$ && (i == 3 || i == 2)) {
      
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
    //   return;
    // }

    // if(i== 3){
    //   app_language_rtl.$ ?slideLeftWidget(newPage: Profile(), context: context):slideRightWidget(newPage: Profile(), context: context);
    //   return;
    // }

    print("i$i");
  }


  void initState() {
    _children = [
      is_logged_in.$ ? Home() : Guest() ,
      Offers(),
      Clubs()
    ];
    fetchAll();
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        //print("_currentIndex");
        if (_currentIndex != 0) {
          fetchAll();
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          CommonFunctions(context).appExitDialog();
        }
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          extendBody: true,
          body: _children[_currentIndex],
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,

            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: SizedBox(
                height: 83,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: onTapped,
                  currentIndex:_currentIndex,
                  backgroundColor: Colors.white.withOpacity(0.95),
                  unselectedItemColor: Color.fromRGBO(168, 175, 179, 1),
                  selectedItemColor: MyTheme.accent_color,
                  selectedLabelStyle: TextStyle(fontWeight:FontWeight.w700,color: MyTheme.accent_color,fontSize: 12 ),
                  unselectedLabelStyle: TextStyle(fontWeight:FontWeight.w400,color:Color.fromRGBO(168, 175, 179, 1),fontSize: 12 ),

                  items: [
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.asset(
                            "assets/home.png",
                            color: _currentIndex == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Color.fromRGBO(153, 153, 153, 1),
                            height: 24,
                          ),
                        ),
                        label:  AppLocalizations.of(context)
                            ?.main_screen_bottom_navigation_home),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.asset(
                            "assets/offers.png",
                            color: _currentIndex == 1
                                ? Theme.of(context).colorScheme.secondary
                                : Color.fromRGBO(153, 153, 153, 1),
                            height: 24,
                          ),
                        ),
                        label: AppLocalizations.of(context)
                            ?.main_screen_bottom_navigation_offers),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/clubs.png",
                          color: _currentIndex == 2
                              ? Theme.of(context).colorScheme.secondary
                              : Color.fromRGBO(153, 153, 153, 1),
                          height: 24,
                        ),
                      ),
                      label: AppLocalizations.of(context)
                          ?.main_screen_bottom_navigation_clubs,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
