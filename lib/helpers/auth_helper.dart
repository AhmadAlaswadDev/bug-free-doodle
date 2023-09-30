import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthHelper {
  setUserData(loginResponse) {
    if (loginResponse.status == true) {
      is_logged_in.$ = true;
      is_logged_in.save();
      has_subscription.$=loginResponse.data['user']['has_subscription'];
      has_subscription.save();
      access_token.$ = loginResponse.data['token'];
      access_token.save();
      user_id.$ = loginResponse.data['user']['id'];
      user_id.save();
      user_name.$ = loginResponse.data['user']['name'];
      user_name.save();
      user_phone.$ = loginResponse.data['user']['phone'];
      user_phone.save();
      user_ams.$ = loginResponse.data['user']['ams'];
      user_ams.save();
    }
  }

  clearUserData() {
      is_logged_in.$ = false;
      is_logged_in.save();
      has_subscription.$=false;
      has_subscription.save();
      access_token.$ = "";
      access_token.save();
      user_id.$ = 0;
      user_id.save();
      user_name.$ = "";
      user_name.save();
      user_email.$ = "";
      user_email.save();
      user_phone.$ = "";
      user_phone.save();
      avatar_original.$ = "";
      avatar_original.save();
  }


  fetch_and_set() async {
    var userByTokenResponse = await AuthRepository().getUserByTokenResponse();

    if (userByTokenResponse.result == true) {
      is_logged_in.$ = true;
      is_logged_in.save();
      user_id.$ = userByTokenResponse.id;
      user_id.save();
      user_name.$ = userByTokenResponse.name;
      user_name.save();
      user_email.$ = userByTokenResponse.email;
      user_email.save();
      user_phone.$ = userByTokenResponse.phone;
      user_phone.save();
      avatar_original.$ = userByTokenResponse.avatar_original;
      avatar_original.save();
    }else{
      is_logged_in.$ = false;
      is_logged_in.save();
      user_id.$ = 0;
      user_id.save();
      user_name.$ = "";
      user_name.save();
      user_email.$ = "";
      user_email.save();
      user_phone.$ = "";
      user_phone.save();
      avatar_original.$ = "";
      avatar_original.save();
    }
  }
}
