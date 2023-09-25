import 'dart:async';

import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/custom/lang_text.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:ammanauto/screens/password_forget.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegistraionOtp extends StatefulWidget {
  RegistraionOtp() : super();

  @override
  _RegistraionOtpState createState() => _RegistraionOtpState();
}

class _RegistraionOtpState extends State<RegistraionOtp> {
  //controllers

  String headeText = "";
  TextEditingController  pin_code_controller = TextEditingController();
StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

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

  onPressConfirm(code) async {

    var registerVerifyResponse =
        await AuthRepository().getSignupVerifyResponse(user_name.$,user_phone.$,code.toString());

    if(registerVerifyResponse.runtimeType.toString() == 'SignupResponse' && registerVerifyResponse.status){
      AuthHelper().setUserData(registerVerifyResponse);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Main();
      }));


    }

  }

  onTapResend() async {
    // var passwordResendCodeResponse = await AuthRepository()
    //     .getPasswordResendCodeResponse(widget.email_or_code, widget.verify_by);
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
                      // decoration: BoxDecoration(
                      //     color: MyTheme.white,
                      //     borderRadius: BorderRadius.circular(8)),
                      // child: Image.asset('assets/lock.png'),
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
                          AppLocalizations.of(context)!.otp_screen_desc,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: PinCodeTextField(
                  length: 5,
                
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: MyTheme.accent_color,
                    inactiveColor: MyTheme.accent_color_shadow,
                    selectedColor: MyTheme.accent_color,
                    inactiveBorderWidth: 1,
                    selectedBorderWidth: 1.5
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: pin_code_controller,
                  onCompleted: (v) {
                    onPressConfirm(v);
                    print("Completed ${v} ");
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  }, appContext: context,
                )
                
                ),
          ],
        ),
      ],
    );
  }
}
