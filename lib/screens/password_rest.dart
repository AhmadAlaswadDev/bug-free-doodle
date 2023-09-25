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
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _validate = false;
  late Map<String, dynamic> validationErrors = {
    "password": [],
    "passwordRepeat": [],
  };
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

  onPressedPasswordRest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var password = _passwordController.text.toString();
      var passwordRepeat = _passwordRepeatController.text.toString();

      AuthRepository()
          .getPasswordChangeResponse(user_phone.$,
              forgort_password_request_token.$, password, passwordRepeat)
          .then((value) => {
                validationErrors = {
                  "password": [],
                  "passwordRepeat": [],
                },
                setState(() {}),
                if (value.runtimeType.toString() ==
                    'PasswordChangeValidationResponse')
                  {
                    validationErrors = value.errors,
                    setState(() {
                      _isLoading = false;
                    }),
                  }
                else if (value.runtimeType.toString() == 'bool' && value)
                  {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()))
                  }
              });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context, "Forget Password!", buildBody(_screen_width, context));
  }

  Form buildBody(double _screen_width, BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.00, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .password_forget_screen_title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w900),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 12),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Container(
                          height: 36,
                          child: TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  validationErrors['password'].clear();
                                  var err = AppLocalizations.of(context)!.new_password_is_required;
                                  validationErrors['password'].add(err);
                                  return err;
                                  // return 'Name is required';
                                }
                                // Add any additional criteria for password validation

                                return null; // Return null if validation passes
                              },
                              onChanged: (phone) {
                                setState(() {});
                                validationErrors['password'].clear();
                              },
                              autofocus: false,
                              obscureText: obscureText,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration:
                                  InputDecorations.buildInputDecorationPassword(
                                      hint_text: AppLocalizations.of(context)!
                                          .password_otp_screen_password,
                                      icon_src: "assets/lock-locked.png",
                                      errorText: validationErrors
                                                  .containsKey('password') &&
                                              validationErrors['password']
                                                  .isNotEmpty
                                          ? 'has_err'
                                          : null,
                                      obscureText: obscureText,
                                      toggleObscureText: toggleObscureText)),
                        ),
                      ),
                      _buildErrorText('password'),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Container(
                          height: 36,
                          child: TextFormField(
                              controller: _passwordRepeatController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  validationErrors['passwordRepeat'].clear();
                                  var err = AppLocalizations.of(context)!.new_password_repeat_is_required;
                                  validationErrors['passwordRepeat'].add(err);
                                  return err;
                                  // return 'Name is required';
                                }
                                if (!value.isEmpty &&
                                    value != _passwordRepeatController.text) {
                                  var err = AppLocalizations.of(context)!.passwords_not_matches;
                                  validationErrors['passwordRepeat'].add(err);
                                  return err;
                                }

                                // Add any additional criteria for password validation

                                return null; // Return null if validation passes
                              },
                              onChanged: (phone) {
                                setState(() {});
                                validationErrors['passwordRepeat'].clear();
                              },
                              autofocus: false,
                              obscureText: obscureTextRepeat,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration:
                                  InputDecorations.buildInputDecorationPassword(
                                      hint_text: AppLocalizations.of(context)!
                                          .password_otp_screen_retype_password,
                                      icon_src: "assets/lock-locked.png",
                                      errorText: validationErrors.containsKey(
                                                  'passwordRepeat') &&
                                              validationErrors['passwordRepeat']
                                                  .isNotEmpty
                                          ? 'has_err'
                                          : null,
                                      obscureText: obscureTextRepeat,
                                      toggleObscureText:
                                          toggleObscureTextRepeat)),
                        ),
                      ),
                      _buildErrorText('passwordRepeat'),
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
                        onPressedPasswordRest();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return PasswordOtp();
                        // }));
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
        ));
  }

  Widget _buildErrorText(key) {
    if (validationErrors.isNotEmpty &&
        validationErrors.containsKey(key) &&
        validationErrors[key].isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(
          validationErrors[key].first,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      );
    } else {
      return SizedBox.shrink(); // Returns an empty widget if there's no error
    }
  }
}
