import 'package:ammanauto/screens/change_language.dart';
import 'package:ammanauto/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:ammanauto/screens/profile.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer() : super();

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onTapLogout(context) async {
    AuthHelper().clearUserData();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Main();
    }),(route)=>false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                is_logged_in.$ == true
                    ? ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                             "${avatar_original.$}",
                          ),
                        ),
                        title: Text("${user_name.$}"),
                        subtitle: Text(
                          //if user email is not available then check user phone if user phone is not available use empty string
                          "${user_email.$ != "" && user_email.$ != null ? user_email.$ : user_phone.$ != "" && user_phone.$ != null ? user_phone.$ : ''}",
                        ))
                    : Text(
                        AppLocalizations.of(context)!.main_drawer_not_logged_in,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                Divider(),
                ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/language.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(
                        AppLocalizations.of(context)!
                            .main_drawer_change_language,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChangeLanguage();
                      }));
                    }),
                ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/home.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_home,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Main();
                      }));
                    }),
                is_logged_in.$ == true
                    ? Column(
                        children: [
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/profile.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .main_drawer_profile,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Profile(show_back_button: true,);
                                }));
                              }),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/order.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .main_drawer_orders,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                 
                              }),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/heart.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .main_drawer_my_wishlist,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                     
                              }),
                          Visibility(
                            visible: conversation_system_status.$,
                            child: ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                leading: Image.asset("assets/chat.png",
                                    height: 16,
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                                title: Text(
                                    AppLocalizations.of(context)!
                                        .main_drawer_messages,
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        fontSize: 14)),
                                onTap: () {
                             ;
                                }),
                          ),
                          wallet_system_status.$
                              ? ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  leading: Image.asset("assets/wallet.png",
                                      height: 16,
                                      color: Color.fromRGBO(153, 153, 153, 1)),
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .main_drawer_wallet,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          fontSize: 14)),
                                  onTap: () {
                        
                                  })
                              : Container(),
                        ],
                      )
                    : Container(),
                Divider(height: 24),
                is_logged_in.$ == false
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/login.png",
                            height: 16,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        title: Text(
                            AppLocalizations.of(context)!.main_drawer_login,
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Registration();
                          }));
                        },
                      )
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/logout.png",
                            height: 16,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        title: Text(
                            AppLocalizations.of(context)!.main_drawer_logout,
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 14)),
                        onTap: () {
                          onTapLogout(context);
                        })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
