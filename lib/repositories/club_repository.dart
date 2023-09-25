import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/models/clubs/club_details_response.dart';
import 'package:ammanauto/models/clubs/clubs_response.dart';
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



}