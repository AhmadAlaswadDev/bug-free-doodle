import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/screens/password_rest.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/screens/password_otp.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordForget extends StatefulWidget {
  @override
  _PasswordForgetState createState() => _PasswordForgetState();
}

class _PasswordForgetState extends State<PasswordForget> {
  String _send_code_by = "email"; //phone or email
  String initialCountry = 'US';
  String _phone = "";

  //controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

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

  onPressSendCode() async {
    var email = _emailController.text.toString();

    var passwordForgetResponse = await AuthRepository()
        .getPasswordForgetResponse(
            _send_code_by == 'email' ? email : _phone, _send_code_by);
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context, "Forget Password!", buildBody(_screen_width, context));
  }

  Column buildBody(double _screen_width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 36),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          color: MyTheme.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset('assets/lock.png'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.00, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .password_forget_screen_title,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        child: Text(
                          AppLocalizations.of(context)!
                              .password_forget_screen_desc,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ))
                  ],
                )),
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
                          hint_text: AppLocalizations.of(context)!.phone,
                          icon_src: "assets/phone.png"),
                    ),
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
                      AppLocalizations.of(context)!
                          .password_forgot_screen_send_sms,
                      style: TextStyle(
                          color: MyTheme.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PasswordOtp();
                      // return PasswordRest();
                    }));
                    // onPressedLogin();
                  },
                ),
              ),
            ),
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
                      AppLocalizations.of(context)!
                          .password_forgot_screen_send_sms,
                      style: TextStyle(
                          color: MyTheme.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      // return PasswordOtp();
                      return PasswordRest();
                    }));
                    // onPressedLogin();
                  },
                ),
              ),
            ),
            Container(
              height: 20,
            ),
          ],
        )
      ],
    );
  }
}
