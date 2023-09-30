import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/models/offers/offer_details_response.dart';
import 'package:ammanauto/models/offers/offers_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class OfferRepository { 

  Future<OffersResponse> getAllOffers(
      { page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/offers/index/" +
        "?page=${page}");
    final response = await http.get(url, headers: {
      "Accept-Language": app_language.$,
      "Authorization": "Bearer ${access_token.$}",
    });

    return OffersResponseFromJson(response.body);
  }

  Future<OfferDetailResponse> getOfferDetails({id}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/offers/show/${id}");
    final response = await http.get(url, headers: {
      "Accept-Language": app_language.$,
      "Authorization": "Bearer ${access_token.$}",
    });

    return OfferDetailResponseFromJson(response.body);
  }




  
}




