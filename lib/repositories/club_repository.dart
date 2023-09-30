import 'dart:convert';

import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/models/clubs/club_details_response.dart';
import 'package:ammanauto/models/clubs/clubs_response.dart';
import 'package:ammanauto/models/clubs/pay_club_with_cc_response.dart';
import 'package:ammanauto/models/validation/pay_club_with_cc_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ammanauto/helpers/shared_value_helper.dart';

class ClubRepository {

  Future<ClubsResponse> getClubs() async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/clubs/index");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "Accept-Language": app_language.$
      },
    );

    debugPrint(response.body);
    return ClubsResponseFromJson(response.body);
  }



  Future<ClubDetailResponse> getClubDetails({id}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/clubs/show/${id}?relations=services");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "Accept-Language": app_language.$
      },
    );

    debugPrint(response.body);
    return ClubDetailResponseFromJson(response.body);
  }



  Future<dynamic> payClubWithCC({id,coupon_code,card_number,expiry_date,cvc,image}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/clubs/${id}/payment/make");

    var request = http.MultipartRequest('POST', url);
    var expiration_date=expiry_date.split("/");
    var space_removed_card_number= card_number.replaceAll(RegExp(r'\s'), "");
    debugPrint(card_number);
    // Add file to the request
    var multipartFile = await http.MultipartFile.fromPath('img_vehicle', image);
    request.files.add(multipartFile);
    
    // Add other inputs to the request
    request.fields['coupon_code'] = coupon_code;
    request.fields['card_number'] = space_removed_card_number;
    request.fields['expiration_month'] = expiration_date[0];
    request.fields['expiration_year'] = expiration_date[1];
    request.fields['cvc'] = cvc;
    request.fields['payment_method']  = 'credit_card' ;
    debugPrint(request.fields.toString());

    // Add headers to the request
    request.headers.addAll({
      "Authorization": "Bearer ${access_token.$}",
      "Accept-Language": app_language.$,
      "Accept":"application/json",
      "Content-Type":"multipart/form-data"
    });

    // Send the request
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    // var parsedJson = jsonDecode(responseBody);

    // final response = await http.post(
    //   url,
    //   headers: {
    //     "Authorization": "Bearer ${access_token.$}",
    //     "Accept-Language": app_language.$,
    //     "Accept":"application/json",
    //     "Content-Type":"application/json"
    //   },
    // );

    debugPrint(response.statusCode.toString());

    if(response.statusCode==422){
      return payClubWithCCValidationResponseFromJson(responseBody);
    }
    else if(response.statusCode==200){
      return PayClubWithCCResponseFromJson(responseBody);
    }
    else{
      return false;
    }
    // return ClubDetailResponseFromJson(response.body);
  }


}