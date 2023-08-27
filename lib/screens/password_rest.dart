import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/screens/password_otp.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordRest extends StatefulWidget {
  @override
  _PasswordRestState createState() => _PasswordRestState();
}

class _PasswordRestState extends State<PasswordRest> {
  String _send_code_by = "email"; //phone or email
  String initialCountry = 'US';
  String _phone = "";
  bool obscureText = true;
  bool obscureTextRepeat = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void toggleObscureTextRepeat() {
    setState(() {
      obscureTextRepeat = !obscureTextRepeat;
    });
  }

  //controllers
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordRepeatController = TextEditingController();

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
    // var email = _emailController.text.toString();

    // var passwordForgetResponse = await AuthRepository()
    //     .getPasswordForgetResponse(
    //         _send_code_by == 'email' ? email : _phone, _send_code_by);
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
            Container(
              height: 72,
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
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        child: Text(
                          'Enter a new password',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ))
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Container(
                      height: 36,
                      child: TextField(
                          controller: _passwordController,
                          autofocus: false,
                          obscureText: obscureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:
                              InputDecorations.buildInputDecorationPassword(
                                  hint_text: AppLocalizations.of(context)!.password_otp_screen_password,
                                  icon_src: "assets/lock-locked.png",
                                  obscureText: obscureText,
                                  toggleObscureText: toggleObscureText)),
                    ),
                  ),
                  Container(
                    height: 36,
                    child: TextField(
                        controller: _passwordRepeatController,
                        autofocus: false,
                        obscureText: obscureTextRepeat,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration:
                            InputDecorations.buildInputDecorationPassword(
                                hint_text: AppLocalizations.of(context)!.password_otp_screen_retype_password,
                                icon_src: "assets/lock-locked.png",
                                obscureText: obscureTextRepeat,
                                toggleObscureText: toggleObscureTextRepeat)),
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
