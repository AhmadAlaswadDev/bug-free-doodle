import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/screens/registration.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:ammanauto/screens/password_forget.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/repositories/profile_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io' show Platform;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';
  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  String _phone = "";
  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressedLogin() async {
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();

    user_name.$ = 'blaxk';
    avatar_original.$ = 'assets/user.png';
    is_logged_in.$ = true;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Main();
    }));

    // if (_login_by == 'email' && email == "") {
    //   ToastComponent.showDialog(AppLocalizations.of(context).login_screen_email_warning, gravity: Toast.center, duration: Toast.lengthLong);
    //   return;
    // } else if (_login_by == 'phone' && _phone == "") {
    //   ToastComponent.showDialog(AppLocalizations.of(context).login_screen_phone_warning, gravity: Toast.center, duration: Toast.lengthLong);
    //   return;
    // } else if (password == "") {
    //   ToastComponent.showDialog(AppLocalizations.of(context).login_screen_password_warning, gravity: Toast.center, duration: Toast.lengthLong);
    //   return;
    // }

    // var loginResponse = await AuthRepository()
    //     .getLoginResponse(_login_by == 'email' ? email : _phone, password);
    // if (loginResponse.result == false) {
    //   ToastComponent.showDialog(loginResponse.message, gravity: Toast.center, duration: Toast.lengthLong);
    // } else {

    //   ToastComponent.showDialog(loginResponse.message, gravity: Toast.center, duration: Toast.lengthLong);
    //   AuthHelper().setUserData(loginResponse);
    //   // push notification starts
    //   if (OtherConfig.USE_PUSH_NOTIFICATION) {
    //     final FirebaseMessaging _fcm = FirebaseMessaging.instance;

    //     await _fcm.requestPermission(
    //       alert: true,
    //       announcement: false,
    //       badge: true,
    //       carPlay: false,
    //       criticalAlert: false,
    //       provisional: false,
    //       sound: true,
    //     );

    //     String fcmToken = await _fcm.getToken();

    //     if (fcmToken != null) {
    //       print("--fcm token--");
    //       print(fcmToken);
    //       if (is_logged_in.$ == true) {
    //         // update device token
    //         var deviceTokenUpdateResponse = await ProfileRepository()
    //             .getDeviceTokenUpdateResponse(fcmToken);
    //       }
    //     }
    //   }

    //   //push norification ends

    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return Main();
    //   }));
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context,
        "${AppLocalizations.of(context)?.login_screen_sign_in} ",
        buildBody(context, _screen_width));
  }

  Widget buildBody(BuildContext context, double _screen_width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: MyTheme.white,
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        Image.asset('assets/login_registration_form_logo.png'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.00, vertical: 10),
              child: Text(
                AppLocalizations.of(context)!.login_screen_sign_in,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 36,
                    child: TextField(
                      controller: _emailController,
                      autofocus: false,
                      decoration: InputDecorations.buildInputDecoration(
                          hint_text:
                              AppLocalizations.of(context)!.login_screen_email,
                          icon_src: "assets/user-avatar.png"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 36,
                    child: TextField(
                        controller: _passwordController,
                        autofocus: false,
                        obscureText: obscureText,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration:
                            InputDecorations.buildInputDecorationPassword(
                                hint_text: AppLocalizations.of(context)!
                                    .registration_screen_password,
                                icon_src: "assets/lock-locked.png",
                                obscureText: obscureText,
                                toggleObscureText: toggleObscureText)),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PasswordForget();
                        }));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          AppLocalizations.of(context)!
                              .login_screen_forgot_password,
                          style: TextStyle(
                              color: MyTheme.accent_color,
                              fontStyle: FontStyle.italic,
                              fontSize: 12),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: MyTheme.accent_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                      AppLocalizations.of(context)!.login_screen_sign_in,
                      style: TextStyle(
                          color: MyTheme.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {
                    onPressedLogin();
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .login_screen_not_registered_yet,
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 45,
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!
                              .login_screen_create_account,
                          style: TextStyle(
                              color: MyTheme.accent_color,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Registration();
                          }));
                        },
                      ),
                    ),
                  ],
                )),
          ],
        )
      ],
    );
  }
}
