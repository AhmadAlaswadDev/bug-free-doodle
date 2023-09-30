import 'dart:convert';

import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/models/coupons/check_coupon_response.dart';
import 'package:ammanauto/models/validation/check_coupon_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class CouonRepoistory {


  Future<dynamic> checkCoupon(String coupon_code) async {

    var post_body = jsonEncode({
      "coupon_code": "${coupon_code}",
    });
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/clubs/check-coupon-code");
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "Accept-Language": app_language.$,
        "Accept": "application/json",
        "Content-Type":"application/json"
      },
      body: post_body
    );

    debugPrint(response.body.toString());
    if(response.statusCode==422){
      return checkCouponValidationResponseFromJson(response.body);
    }
    else{
      return checkCouponResponseFromJson(response.body);

    }
  }




}