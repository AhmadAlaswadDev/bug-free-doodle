import 'package:flutter/material.dart';
import 'package:ammanauto/my_theme.dart';

class InputDecorations {


  static InputDecoration buildInputDecoration(
      {hint_text = "",icon_src="", horizontalPadding = 16.00, verticalPadding = 0.00}) {
    return InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(icon_src),
        ),
        hintText: hint_text,
        filled: true,
        fillColor: MyTheme.white,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.00,
        ));
  }


  static InputDecoration buildInputDecorationPassword(
      {hint_text = "",icon_src="", horizontalPadding = 16.00, verticalPadding = 0.00,obscureText, toggleObscureText}) {
    return InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(icon_src),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          ),
          color: Colors.red,
          padding: EdgeInsets.all(0),
          onPressed: toggleObscureText,
        ),
        hintText: hint_text,
        filled: true,
        fillColor: MyTheme.white,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.00,
        ));
  }












  static InputDecoration buildInputDecoration_1(
      {hint_text = "", horizontalPadding = 16.00, verticalPadding = 0.00}) {
    return InputDecoration(
        hintText: hint_text,
        filled: true,
        fillColor: MyTheme.white,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.noColor, width: 0.2),
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.00,
        ));
  }

  static InputDecoration buildInputDecoration_phone({hint_text = ""}) {
    return InputDecoration(
        hintText: hint_text,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0))),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0));
  }

  static InputDecoration buildInputDecorationMobile(
      {hint_text = "", horizontalPadding = 16.00, verticalPadding = 0.00}) {
    return InputDecoration(
      isDense: true,
      hintText: hint_text,
      filled: true,
      border: OutlineInputBorder(),
      fillColor: MyTheme.white,
      hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyTheme.noColor, width: 0.2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0))),
      contentPadding: EdgeInsets.symmetric(vertical: 5),
    );
  }
}
