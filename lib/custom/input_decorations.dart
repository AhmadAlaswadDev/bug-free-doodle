import 'package:flutter/material.dart';
import 'package:ammanauto/my_theme.dart';

class InputDecorations {
  static InputDecoration buildInputDecoration(
      {hint_text = "",
      errorText = null,
      icon_src = "",
      horizontalPadding = 16.00,
      verticalPadding = 0.00}) {
    return InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            icon_src,
            color: errorText == 'has_err' ? Colors.red : MyTheme.textfield_grey,
          ),
        ),
        hintText: hint_text,
        errorText: errorText,
        errorStyle: TextStyle(fontSize: 0),
        filled: true,
        fillColor: MyTheme.white,
        hintStyle: TextStyle(
            fontSize: 12.0,
            color:
                errorText == 'has_err' ? Colors.red : MyTheme.textfield_grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.00, vertical: 12));
  }

  static InputDecoration buildInputDecorationPassword(
      {hint_text = "",
      icon_src = "",
      horizontalPadding = 16.00,
      verticalPadding = 0.00,
      obscureText,
      toggleObscureText,
      errorText}) {
    return InputDecoration(
      errorStyle: TextStyle(fontSize: 0),
      errorText: errorText,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          icon_src,
          color: errorText == 'has_err' ? Colors.red : MyTheme.textfield_grey,
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        color: Colors.red,
        padding: EdgeInsets.all(0),
        onPressed: toggleObscureText,
      ),
      hintText: hint_text,
      filled: true,
      fillColor: MyTheme.white,
      hintStyle: TextStyle(
          fontSize: 12.0,
          color: errorText == 'has_err' ? Colors.red : MyTheme.textfield_grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.00, vertical: 12),
    );
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
      {hint_text = "", horizontalPadding = 16.00, verticalPadding = 0.00,errorText = null}) {
    return InputDecoration(
      hintText: hint_text,
      filled: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
      ),
      fillColor: MyTheme.white,
      hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
      counterText: '',
      errorText:errorText,
    );
  }

  static InputDecoration buildInputDecoration_2( {hint_text,border} ) {
    return InputDecoration(
      counterText: '',
        border: border,
        focusedBorder: InputBorder.none,
        enabledBorder:border,
        hintText: hint_text,
        filled: true,
        fillColor: MyTheme.light_grey,
        contentPadding: EdgeInsets.only(bottom: 10, right: 6, left: 6));
  }
}
