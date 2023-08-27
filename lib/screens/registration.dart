import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/screens/main.dart';
// import 'package:ammanauto/screens/common_webview_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';

  String _phone = "";
  String _countryCode = "";
  bool _isAgree = false;

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _phoneNumberController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // TextEditingController _passwordConfirmController = TextEditingController();

  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

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

  onPressSignUp() async {
    int randomNumber = Random().nextInt(10000);
    String name = _nameController.text.toString();
    String phone = _phone;
    String email = 'user$randomNumber@svg.com';
    String password = 'password$randomNumber';
    String password_confirm = 'password$randomNumber';
    String _register_by = 'phone';
    int countryId;
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context,
        "${AppLocalizations.of(context)!.registration_screen_join} " +
            AppConfig.app_name,
        buildBody(context, _screen_width));
  }

  Column buildBody(BuildContext context, double _screen_width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Container()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.00, vertical: 10),
              child: Text(
                AppLocalizations.of(context)!.login_screen_create_account,
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
                      controller: _nameController,
                      autofocus: false,
                      decoration: InputDecorations.buildInputDecoration(
                          hint_text: AppLocalizations.of(context)!
                              .registration_screen_email,
                          icon_src: "assets/user-avatar.png"),
                    ),
                  ),
                ],
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
                      controller: _phoneController,
                      autofocus: false,
                      decoration: InputDecorations.buildInputDecoration(
                          hint_text: AppLocalizations.of(context)!.phone,
                          icon_src: "assets/phone.png"),
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
                      AppLocalizations.of(context)!.login_screen_create_account,
                      style: TextStyle(
                        color: MyTheme.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      )),
                  onPressed: () {
                    // onPressedLogin();
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
                          .registration_screen_already_have_account,
                      style: TextStyle(color: MyTheme.font_grey, fontSize: 12),
                    ),
                    Container(
                      height: 45,
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!
                              .registration_screen_log_in,
                          style: TextStyle(
                              color: MyTheme.accent_color,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
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
