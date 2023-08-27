import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:one_context/one_context.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/screens/splash_screen.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/providers/locale_provider.dart';
import 'app_config.dart';
import 'lang_config.dart';
// import 'package:al_ruayah_al_thakiah_eng/helpers/addons_helper.dart';
// import 'package:al_ruayah_al_thakiah_eng/helpers/auth_helper.dart';
// import 'package:al_ruayah_al_thakiah_eng/helpers/business_setting_helper.dart';
// import 'package:al_ruayah_al_thakiah_eng/other_config.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:al_ruayah_al_thakiah_eng/screens/splash.dart';
// import 'package:al_ruayah_al_thakiah_eng/services/push_notification_service.dart';
// import 'package:firebase_core/firebase_core.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  // AddonsHelper().setAddonsData();
  // BusinessSettingHelper().setBusinessSettingData();
  // app_language.load();
  // app_mobile_language.load();
  // app_language_rtl.load();
  //
  // access_token.load().whenComplete(() {
  //   AuthHelper().fetch_and_set();
  // });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
            builder: OneContext().builder,
            navigatorKey: OneContext().navigator.key,
            title: AppConfig.app_name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: MyTheme.white,
              scaffoldBackgroundColor: MyTheme.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              /*textTheme: TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(fontSize: 12.0),
            )*/
              //
              // the below code is getting fonts from http
              textTheme: GoogleFonts.publicSansTextTheme(textTheme).copyWith(
                bodyText1:
                    GoogleFonts.publicSans(textStyle: textTheme.bodyText1),
                bodyText2: GoogleFonts.publicSans(
                    textStyle: textTheme.bodyText2, fontSize: 12),
              ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MyTheme.accent_color),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: provider.locale,
            supportedLocales: LangConfig().supportedLocales(),
            home: SplashScreen(),
            // home: Splash(),
          );
        }));
  }
}
