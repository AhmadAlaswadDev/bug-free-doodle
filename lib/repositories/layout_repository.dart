import 'package:ammanauto/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:ammanauto/models/guest_layout_response.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';

class layoutRepository {

  Future<GuestLayoutResponse> getHomeLayout() async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/layouts/guest");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );

    return guestLayoutResponseFromJson(response.body);
  }



}