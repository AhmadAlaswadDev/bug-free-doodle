import 'dart:io';

import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/models/clubs/club_details_response.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/repositories/club_repository.dart';
import 'package:ammanauto/repositories/coupon_repository.dart';
import 'package:ammanauto/screens/confirm_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Pay extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;
  var club_details = null;

  Pay({
    required this.club_details,
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _mainScrollController = ScrollController();
  int _currentYear = DateTime.now().year % 100;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String _payment_mehod = 'cc';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  bool has_valid_coupon = false;
  bool _isLoading = false;
  final TextEditingController couponController = TextEditingController();
  String coupon_discount_value = '';
  String coupon_discount_type = '';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  onPressedApplyCouponCode() {
    var coupon_code = couponController.text;
    CouonRepoistory().checkCoupon(coupon_code).then((value) {
      if (value.runtimeType.toString() == 'CheckCouponValidationResponse') {
      } else {
        // debugPrint(value.data['is_valid']);
        if (value.data['is_valid']) {
          coupon_discount_value = value.data['discount_value'].toString();
          coupon_discount_type = value.data['discount_type'];
          has_valid_coupon = true;
          setState(() {});
        }
      }
    });
  }

  onPressedPay() {
    var id = widget.club_details.id;
    var coupon_code = couponController.text;
    var card_number = cardNumberController.text;
    var expiry_date = expiryDateController.text;
    var cvc = cvcController.text;

    setState(() {
      _isLoading = true;
    });

    ClubRepository()
        .payClubWithCC(
            id: id,
            coupon_code: coupon_code,
            card_number: card_number,
            expiry_date: expiry_date,
            cvc: cvc,
            image: _image!.path)
        .then((value) {
      if (value.runtimeType.toString() == 'PayClubWithCCResponse') {
        //redirect user
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmPayment(url: value.redirect_url),
          ),
        );
      } 
        setState(() {
          _isLoading = false;
        });

      debugPrint(value.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
    fetchAll();
  }

  fetchAll() {}

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                //drawer: MainDrawer(),
                body: Stack(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
                      child: CustomScrollView(
                          controller: _mainScrollController,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          slivers: <Widget>[
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Vehicle Registartion / istimara',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: _pickImage,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Upload ',
                                                style: TextStyle(
                                                    color: MyTheme.accent_color,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Image.asset(
                                                'assets/gallery.png',
                                                width: 22,
                                              )
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            backgroundColor: MyTheme.light_grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: _image == null
                                              ? const Text('No image selected.')
                                              : Image.file(
                                                  File(_image!.path),
                                                  width: 44, // maximum width
                                                  height: 26,
                                                ),

                                          // Image.asset(
                                          //                   'assets/id.png',
                                          //                   width: 46,
                                          //                 ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text('Your Order',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Product'),
                                              Text('Total')
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(widget.club_details.name),
                                              Text(widget.club_details.price
                                                  .toString())
                                            ],
                                          ),
                                          buildCouponLine(),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.club_details.vat_text,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                widget.club_details
                                                    .total_price_with_vat,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      'DO YOU HAVE CUPON?',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: MyTheme.accent_color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/coupon.png',
                                          width: 37,
                                        ),
                                        SizedBox(
                                          width: 126,
                                          height: 28,
                                          child: TextField(
                                            controller: couponController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: '',
                                                filled: true,
                                                fillColor: MyTheme.light_grey,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 10,
                                                        right: 6,
                                                        left: 6)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 72,
                                          height: 24,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                onPressedApplyCouponCode();
                                              },
                                              child: const Text('Apply'),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      MyTheme.accent_color)),
                                        ),
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Material(
                                            color: MyTheme
                                                .green, // set background color
                                            elevation: 6.0, // give it elevation
                                            borderRadius: BorderRadius.circular(
                                                4.0), // give it rounded corners
                                            child: IconButton(
                                              padding: const EdgeInsets.all(
                                                  0), // remove padding
                                              icon: const Icon(Icons.check,
                                                  size: 16),
                                              color: Colors
                                                  .white, // set icon color
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Material(
                                              color: MyTheme
                                                  .red, // set background color
                                              elevation:
                                                  6.0, // give it elevation
                                              borderRadius: BorderRadius.circular(
                                                  4.0), // give it rounded corners
                                              child: IconButton(
                                                padding: const EdgeInsets.all(
                                                    0), // remove padding
                                                icon: const Icon(Icons.close,
                                                    size: 16),
                                                color: Colors
                                                    .white, // set icon color
                                                onPressed: () {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      'PAYMENT METHOD',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale:
                                                0.6, // Adjust the scale factor as per your needs
                                            child: Radio(
                                              value: 'cc',
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4),
                                              groupValue: _payment_mehod,
                                              onChanged: (value) {},
                                            ),
                                          ), // Adjust based on your needs
                                          Image.asset(
                                            'assets/cc.png',
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: buildCreditCardForm(),
                                      ),
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 0.6,
                                            child: Radio(
                                              value: 'apple',
                                              groupValue: _payment_mehod,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                '3 interst free payment of ',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const Text('89,6 SAR',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6),
                                                child: Text('learn more',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: MyTheme
                                                            .accent_color)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/interst.png',
                                          width: 280,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Container(
                                              width: double.infinity,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  backgroundColor:
                                                      MyTheme.accent_color,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0)),
                                                  padding: !_isLoading
                                                      ? const EdgeInsets
                                                          .symmetric(
                                                          vertical: 14)
                                                      : null,
                                                ),
                                                child: _isLoading
                                                    ? Container(
                                                        height:
                                                            36, // Set the desired height
                                                        child: LoadingIndicator(
                                                          indicatorType:
                                                              Indicator
                                                                  .ballPulseSync,
                                                          colors: [
                                                            const Color
                                                                .fromARGB(255,
                                                                255, 255, 255)
                                                          ], // Customize the color if needed
                                                          strokeWidth:
                                                              2, // Customize the stroke width if needed
                                                          backgroundColor: Colors
                                                              .transparent, // Customize the background color if needed
                                                        ))
                                                    : Text(
                                                        'Pay',
                                                        style: TextStyle(
                                                          color: MyTheme.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                onPressed: _isLoading
                                                    ? null
                                                    : () {
                                                        onPressedPay();
                                                      },
                                              )))
                                    ],
                                  )
                                ],
                              ),
                            ]))
                          ]))
                ]))));
  }

  Widget buildCreditCardForm() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 36,
            child: TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                CreditCardNumberFormatter(),
              ],
              maxLength: 19,
              decoration: InputDecorations.buildInputDecoration_2(
                hint_text: 'Card number',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        Directionality.of(context) == TextDirection.ltr
                            ? 5.0
                            : 0.0),
                    bottomLeft: Radius.circular(
                        Directionality.of(context) == TextDirection.ltr
                            ? 5.0
                            : 0.0),
                    topRight: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? 5.0
                            : 0.0),
                    bottomRight: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? 5.0
                            : 0.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a card number';
                }
                // Additional validation logic can be added here
                return null;
              },
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 36,
            child: TextFormField(
              maxLength: 5,
              decoration: InputDecorations.buildInputDecoration_2(
                  hint_text: 'MM / YY',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.only(),
                  )),
              controller: expiryDateController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                _ExpiryDateInputFormatter(),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an expiry date';
                }
                // Additional validation logic can be added here
                return null;
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 36,
            child: TextFormField(
              controller: cvcController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration: InputDecorations.buildInputDecoration_2(
                hint_text: 'CVC',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? 5.0
                            : 0.0),
                    bottomLeft: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? 5.0
                            : 0.0),
                    topRight: Radius.circular(
                        Directionality.of(context) == TextDirection.ltr
                            ? 5.0
                            : 0.0),
                    bottomRight: Radius.circular(
                        Directionality.of(context) == TextDirection.ltr
                            ? 5.0
                            : 0.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a CVC';
                }
                // Additional validation logic can be added here
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCouponLine() {
    return has_valid_coupon
        ? Column(
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Coupon'),
                  Text(' $coupon_discount_value $coupon_discount_type')
                ],
              ),
            ],
          )
        : Container();
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final int length = text.length;
    debugPrint('');
    if (length < oldValue.text.length && length == 3 && text.endsWith('/')) {
      return TextEditingValue(
        text: text.substring(0, length - 2),
        selection: TextSelection.collapsed(offset: length - 2),
      );
    } else if (length == 2 && text.contains('/')) {
      return TextEditingValue(
        text: '${text.substring(0, 1)}',
        selection: const TextSelection.collapsed(offset: 3),
      );
    } else if (length == 1 && int.tryParse(text)! > 1) {
      return TextEditingValue(
        text: '0$text/',
        selection: TextSelection.collapsed(offset: length + 2),
      );
    } else if (length == 2) {
      if (int.tryParse(text)! > 12) {
        return TextEditingValue(
          text: text.substring(0, length - 1),
          selection: const TextSelection.collapsed(offset: 1),
        );
      } else {
        return TextEditingValue(
          text: '$text/2',
          selection: const TextSelection.collapsed(offset: 4),
        );
      }
    } else if (length == 5) {
      final currentYear = DateTime.now().year % 100;
      final expirationYear = int.tryParse(text.substring(length - 2));
      debugPrint('${currentYear}   ${expirationYear}');
      if (expirationYear != null && expirationYear < currentYear) {
        return TextEditingValue(
          text: text.substring(0, length - 1),
          selection: TextSelection.collapsed(offset: length - 1),
        );
      }
    }

    return newValue;
  }
}

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedValue = _formatCreditCardNumber(newValue.text);
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatCreditCardNumber(String input) {
    // Remove any non-digit characters from the input
    final digitsOnly = input.replaceAll(RegExp(r'\D'), '');

    // Split the input into groups of 4 characters
    final groups = <String>[];
    for (var i = 0; i < digitsOnly.length; i += 4) {
      final end = i + 4;
      groups.add(digitsOnly.substring(i, end));
    }

    // Join the groups with a space separator
    final formattedValue = groups.join(' ');

    return formattedValue;
  }
}
