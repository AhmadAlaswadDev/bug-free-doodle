import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/custom/lang_text.dart';
import 'package:ammanauto/custom/pin_code_text_field.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/password_forget.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordOtp extends StatefulWidget {
  PasswordOtp() : super();

  @override
  _PasswordOtpState createState() => _PasswordOtpState();
}

class _PasswordOtpState extends State<PasswordOtp> {
  //controllers
  TextEditingController _codeController = TextEditingController();
  bool _resetPasswordSuccess = false;

  String headeText = "";

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      headeText =
          AppLocalizations.of(context)!.password_otp_screen_enter_the_code_sent;
      setState(() {});
    });
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

  onPressConfirm() async {
    var code = _codeController.text.toString();

    // var passwordConfirmResponse =
    //     await AuthRepository().getPasswordConfirmResponse(code, password);
  }

  onTapResend() async {
    // var passwordResendCodeResponse = await AuthRepository()
    //     .getPasswordResendCodeResponse(widget.email_or_code, widget.verify_by);
  }

  gotoLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context, headeText, buildBody(context, _screen_width));
  }

  Widget buildBody(BuildContext context, double _screen_width) {
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
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        child: Text(
                          AppLocalizations.of(context)!
                              .otp_screen_desc,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ))
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: PinCodeTextField(length: 5,),
            ),
          ],
        ),
      ],
    );
  }
}
