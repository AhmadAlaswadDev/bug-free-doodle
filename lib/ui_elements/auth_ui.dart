import 'package:ammanauto/custom/box_decorations.dart';
import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom/device_info.dart';

class AuthScreen {
  static Widget buildScreen(
      BuildContext context, String headerText, Widget child) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          //key: _scaffoldKey,
          //drawer: MainDrawer(),
          backgroundColor: Colors.white,
          //appBar: buildAppBar(context),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: child,
                  ),
                ),
              ],
            ),
          )

          // Stack(
          //   children: [
          //     CustomScrollView(
          //       //controller: _mainScrollController,
          //       physics: const BouncingScrollPhysics(
          //           parent: AlwaysScrollableScrollPhysics()),
          //       slivers: [
          //         SliverList(
          //           delegate: SliverChildListDelegate(
          //               [
          //             Padding(
          //               padding: const EdgeInsets.only(top: 16.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Container(
          //                     padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
          //                     width: 160,
          //                     height: 160,
          //                     decoration: BoxDecoration(
          //                         color: MyTheme.white,
          //                         borderRadius: BorderRadius.circular(8)),
          //                     child: Image.asset('assets/login_registration_form_logo.png'),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(bottom: 20.0,top: 6),
          //               child: Text(
          //                 headerText,

          //                 style: TextStyle(
          //                     color: MyTheme.white,
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.w600),
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 18.0),
          //               child: Container(
          //                   height: MediaQuery.of(context).size.height ,
          //                   padding: EdgeInsets.symmetric(vertical: 0),
          //                   child: child,),
          //             ),
          //           ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
