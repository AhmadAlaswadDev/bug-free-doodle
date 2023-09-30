import 'package:ammanauto/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ammanauto/models/guest_layout_response.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';

class layoutRepository {

  Future<GuestLayoutResponse> getHomeGuestLayout() async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/home");
        debugPrint(url.toString());
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "Accept-Language": app_language.$
      },
    );

    debugPrint(app_language.$);
    return guestLayoutResponseFromJson(response.body);
  }



}