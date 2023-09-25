import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/models/validation/signup_validation_response.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/screens/registration_otp.dart';
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
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';
  String _phone = "";

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _validate = false;
  late Map<String, dynamic> validationErrors = {
    "name": [],
    "phone": [],
    "password": [],
  };
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
    String phone = _phone;
    if (phone.isEmpty) {
      validationErrors['phone'].add(AppLocalizations.of(context)!.phone_number_is_required);
    }
    if (_formKey.currentState!.validate() && phone.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String name = _nameController.text.toString();
      String password = _passwordController.text.toString();
      debugPrint(_phone.toString());
      var response = AuthRepository().getSignupResponse(name, phone, password);
      response.then((value) => {
            debugPrint(value.runtimeType.toString()),
            validationErrors = {
              "name": [],
              "phone": [],
              "password": [],
            },
            setState(() {}),

            //display validation errors
            if (value.runtimeType.toString() == 'SignupValidationResponse')
              {
                validationErrors = value.errors,
                setState(() {
                  _isLoading = false;
                }),
              }
            else if (value.runtimeType.toString() == 'bool' && value)
              {
                user_name.$ = name,
                user_phone.$ = phone,
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegistraionOtp()))
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
        context,
        "${AppLocalizations.of(context)!.registration_screen_join} " +
            AppConfig.app_name,
        buildBody(context, _screen_width));
  }

  buildBody(BuildContext context, double _screen_width) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        child: TextFormField(
                          controller: _nameController,
                          onChanged: (phone) {
                            setState(() {});
                            validationErrors['name'].clear();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              validationErrors['name'].clear();
                              var err = AppLocalizations.of(context)!.name_is_required;
                              validationErrors['name'].add(err);
                              return err;
                              // return 'Name is required';
                            }
                            // Add any additional criteria for password validation

                            return null; // Return null if validation passes
                          },
                          autofocus: false,
                          decoration: InputDecorations.buildInputDecoration(
                              hint_text: AppLocalizations.of(context)!
                                  .registration_screen_name,
                              icon_src: "assets/user-avatar.png",
                              errorText: validationErrors.containsKey('name') &&
                                      validationErrors['name'].isNotEmpty
                                  ? 'has_err'
                                  : null),
                        ),
                      ),
                      _buildErrorText('name'),
                    ],
                  ),
                ),
                IntlPhoneField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _phoneController,
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
                //  _buildErrorText('phone'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
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
                            validator: (value) {
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
                            onChanged: (phone) {
                              setState(() {});
                              validationErrors['password'].clear();
                            },
                            decoration:
                                InputDecorations.buildInputDecorationPassword(
                                    hint_text: AppLocalizations.of(context)!
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
                          )),
                      _buildErrorText('password'),
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
                              height: 32, // Set the desired height
                              child: const LoadingIndicator(
                                indicatorType: Indicator.ballPulseSync,
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255)
                                ], // Customize the color if needed
                                strokeWidth:
                                    2, // Customize the stroke width if needed
                                backgroundColor: Colors
                                    .transparent, // Customize the background color if needed
                              ))
                          : Text(
                              AppLocalizations.of(context)!
                                  .login_screen_create_account,
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              )),
                      onPressed: () {
                        onPressSignUp();
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
                          style:
                              TextStyle(color: MyTheme.font_grey, fontSize: 12),
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
