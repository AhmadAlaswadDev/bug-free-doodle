// ignore_for_file: unused_field

import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/providers/locale_provider.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen() : super();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // PackageInfo _packageInfo = PackageInfo(
  //   appName: AppConfig.app_name,
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  // );

  Future<void> _initPackageInfo() async {
    // final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      // _packageInfo = info;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getSharedValueHelperData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            Future.delayed(Duration(seconds: 3)).then((value) {
              Provider.of<LocaleProvider>(context,listen: false).setLocale(app_mobile_language.$);
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                    return Main(go_back: false,);
                  },
                  ),(route)=>false,);
            }
            );

          }
          return splashScreen();
        }
    );
  }

  Widget splashScreen() {
    return Container(
      width: DeviceInfo(context).height,
      height: DeviceInfo(context).height,
      color:  MyTheme.splash_screen_color,
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              top: DeviceInfo(context).height/2-72,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Hero(
                      tag: "splashscreenImage",
                      child: Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        child: Image.asset(
                            "assets/splash_screen_logo.png",
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

  Future<String>  getSharedValueHelperData()async{
    access_token.load().whenComplete(() {
      AuthHelper().fetch_and_set();
    });
    await app_language.load();
    await app_mobile_language.load();
    await app_language_rtl.load();

    // print("new splash screen ${app_mobile_language.$}");
    // print("new splash screen app_language_rtl ${app_language_rtl.$}");

    return app_mobile_language.$;

  }
}
