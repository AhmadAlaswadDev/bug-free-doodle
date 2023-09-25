import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/screens/registration.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:ammanauto/screens/password_forget.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/repositories/profile_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io' show Platform;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String initialCountry = 'US';
  String _phone = "";
  bool obscureText = true;

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late Map<String, dynamic> validationErrors = {
    "phone": [],
    "password": [],
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

  onPressedLogin() async {
    var phone = _phone;
    var password = _passwordController.text.toString();

    if (phone.isEmpty) {
      validationErrors['phone'].add(AppLocalizations.of(context)!.phone_number_is_required);
    }
    if (_formKey.currentState!.validate() && phone.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      // var phone =  _phoneNumberController.text.toString();

      var response = AuthRepository().getLoginResponse(phone, password);
      response.then((value) => {
            validationErrors = {
              "phone": [],
              "password": [],
            },
            setState(() {}),
            if (value.runtimeType.toString() == 'LoginValidationResponse')
              {
                setState(() {
                  _isLoading = false;
                }),
                validationErrors = value.errors,
              }
            else if (value.runtimeType.toString() == 'LoginResponse')
              {
                AuthHelper().setUserData(value),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Main()))
              }
              else{
                _isLoading = false,
                setState(() {})
              }
          });
    } else {
      debugPrint(validationErrors.toString());
      
      setState(() {});
    }

    // user_name.$ = 'blaxk';
    // avatar_original.$ = 'assets/user.png';
    // is_logged_in.$ = true;
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
    return Form(
        key: _formKey,
        child: Column(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: MyTheme.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                            'assets/login_registration_form_logo.png'),
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
                IntlPhoneField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _phoneNumberController,
                  invalidNumberMessage: '',
                  initialCountryCode: 'AE',
                  validator: (phone) {
                    validationErrors['phone'].clear();
                    return null;

                    /// logic to validate number
                    /// isValid = true
                  },
                  textAlign: TextAlign.start,
                  onChanged: (phone) {
                    setState(() {});
                    validationErrors['phone'].clear();
                    _phone = phone.completeNumber;
                  },
                  decoration: InputDecorations.buildInputDecorationMobile(
                      errorText: getInputError('phone')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: null,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        child: TextFormField(
                          controller: _passwordController,
                          onChanged: (value) {
                            validationErrors['password'].clear();
                            setState(() {});
                          },
                          validator: (value) {
                            validationErrors['password'].clear();
                            if (value == null || value.isEmpty) {
                              var err = AppLocalizations.of(context)!.password_is_required;
                              validationErrors['password'].add(err);
                              return err;
                            }
                            if (value.length < 8) {
                              var err =
                                  AppLocalizations.of(context)!.password_must_be_at_least_have_8_letters;
                              validationErrors['password'].add(err);
                              return err;
                            }

                            return null; // Return null if validation passes
                          },
                          autofocus: false,
                          obscureText: obscureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:
                              InputDecorations.buildInputDecorationPassword(
                                  hint_text:
                                      AppLocalizations.of(context)!
                                          .registration_screen_password,
                                  icon_src: "assets/lock-locked.png",
                                  obscureText: obscureText,
                                  toggleObscureText: toggleObscureText,
                                  errorText: validationErrors
                                              .containsKey('password') &&
                                          validationErrors['password']
                                              .isNotEmpty
                                      ? 'has_err'
                                      : null),
                        ),
                      ),
                      _buildErrorText('password'),
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
                        padding: !_isLoading
                            ? const EdgeInsets.symmetric(vertical: 14)
                            : null,
                      ),
                      child: _isLoading
                          ? Container(
                              height: 36, // Set the desired height
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulseSync,
                                colors: [
                                  const Color.fromARGB(255, 255, 255, 255)
                                ], // Customize the color if needed
                                strokeWidth:
                                    2, // Customize the stroke width if needed
                                backgroundColor: Colors
                                    .transparent, // Customize the background color if needed
                              ))
                          : Text(
                              AppLocalizations.of(context)!
                                  .login_screen_sign_in,
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                      //  Text(
                      //     AppLocalizations.of(context)!.login_screen_sign_in,
                      //     style: TextStyle(
                      //         color: MyTheme.white,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.normal)),
                      onPressed: _isLoading
                          ? null
                          : () {
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

  getInputError(key) {
    debugPrint(
        '${validationErrors.isNotEmpty.toString()} ${validationErrors.containsKey(key).toString()} ${validationErrors[key].isNotEmpty.toString()} ');
    if (validationErrors.isNotEmpty &&
        validationErrors.containsKey(key) &&
        validationErrors[key].isNotEmpty) {
      return validationErrors[key].first;
    }
    return null;
  }
}
