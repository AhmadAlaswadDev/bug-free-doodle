import 'dart:io';

import 'package:ammanauto/custom/input_decorations.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Pay extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Pay({
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
  String _payment_mehod = 'cc';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  int _currentYear = DateTime.now().year % 100;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  // Future<void> _uploadImage() async {
  // if (_image == null) {
  //   return;
  // }
  // }

  // final String path = _image!.path;
  // final request = http.MultipartRequest('POST', url);
  // request.files.add(await http.MultipartFile.fromPath('file', 'path_to_your_file'));
  // final http.StreamedResponse response = await request.send();

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
                        vertical: 20, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Vehicle Registartion / istimara',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: _pickImage,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Upload ',
                                      style: TextStyle(
                                          color: MyTheme.accent_color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: MyTheme.light_grey,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: _image == null
                                    ? Text('No image selected.')
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
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text('Product'), Text('Total')],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Basic x 1'),
                                    Text('269 SAR')
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL WITH VAT 15% ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '269 SAR',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Text(
                          'DO YOU HAVE CUPON?',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.accent_color),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/coupon.png',
                                width: 37,
                              ),
                              SizedBox(
                                width: 126,
                                height: 24,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: '',
                                      filled: true,
                                      fillColor: MyTheme.light_grey,
                                      contentPadding: EdgeInsets.only(
                                          bottom: 10, right: 6, left: 6)),
                                ),
                              ),
                              SizedBox(
                                width: 72,
                                height: 24,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Apply'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyTheme.accent_color)),
                              ),
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MyTheme.green),
                                  onPressed: () {},
                                  child: Text(
                                    '1',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MyTheme.red),
                                  onPressed: () {},
                                  child: Text('X'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'PAYMENT METHOD',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        VisualDensity(horizontal: -4),
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
                                        VisualDensity(horizontal: -4),
                                    onChanged: (value) {},
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '3 interst free payment of ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text('89,6 SAR',
                                        style: TextStyle(fontSize: 14)),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      child: Text('learn more',
                                          style: TextStyle(fontSize: 12)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
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
              maxLength: 16,
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
                  border: OutlineInputBorder(
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
        selection: TextSelection.collapsed(offset: 3),
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
          selection: TextSelection.collapsed(offset: 1),
        );
      } else {
        return TextEditingValue(
          text: '$text/2',
          selection: TextSelection.collapsed(offset: 4),
        );
      }
    } else if (length == 5) {
      final currentYear = DateTime.now().year % 100;
      final expirationYear = int.tryParse(text.substring(length - 2));
      debugPrint('${currentYear}   ${expirationYear}');
      if (expirationYear != null && expirationYear > currentYear) {
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
