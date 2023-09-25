import 'dart:async';

import 'package:ammanauto/custom/box_decorations.dart';
import 'package:ammanauto/custom/device_info.dart';
import 'package:ammanauto/custom/lang_text.dart';
import 'package:ammanauto/helpers/auth_helper.dart';
import 'package:ammanauto/screens/change_language.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:ammanauto/screens/profile_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/ui_sections/drawer.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/repositories/profile_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

class Profile extends StatefulWidget {
  Profile({this.show_back_button = false}) : super();

  bool show_back_button;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (is_logged_in.$ == true) {
      fetchAll();
    }
  }

  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchAll();
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }

  fetchAll() {}

  reset() {
    setState(() {});
  }

  onTapLogout(context) async {
    AuthHelper().clearUserData();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Main();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
    final Map<String, dynamic> accountSettingsData = {
      'title': AppLocalizations.of(context)!.profile_screen_account,
      'tabs': [
        {
          'title': AppLocalizations.of(context)!.inbox,
          'image': 'assets/inbox.png',
          'items': [
            {
              "name": AppLocalizations.of(context)!.first_dropdown,
              'redirect_to': 'nowhere'
            },
            {
              "name": AppLocalizations.of(context)!.second_dropdown,
              'redirect_to': 'nowhere'
            },
          ]
        },
        {
          'title': AppLocalizations.of(context)!.documents,
          'image': 'assets/documents.png',
          'items': [
            {
              "name": AppLocalizations.of(context)!.first_dropdown,
              'redirect_to': 'nowhere'
            },
            {
              "name": AppLocalizations.of(context)!.second_dropdown,
              'redirect_to': 'nowhere'
            },
          ]
        },
      ]
    };

    final Map<String, dynamic> appSettingsData = {
      'title': AppLocalizations.of(context)!.app,
      'tabs': [
        {
          'title': AppLocalizations.of(context)!.settings,
          'image': 'assets/settings_ico.png',
          'items': [
            {
              "name":
                  AppLocalizations.of(context)!.change_language_change_language,
              'redirect_to': 'change_language'
            },
          ]
        },
        {
          'title': AppLocalizations.of(context)!.security,
          'image': 'assets/security.png',
          'items': [
            {
              "name": AppLocalizations.of(context)!.first_dropdown,
              'redirect_to': 'nowhere'
            },
            {
              "name": AppLocalizations.of(context)!.second_dropdown,
              'redirect_to': 'nowhere'
            },
          ]
        },
        {
          'title': AppLocalizations.of(context)!.notifications,
          'image': 'assets/notifications.png',
          'items': [
            {
              "name": AppLocalizations.of(context)!.first_dropdown,
              'redirect_to': 'nowhere'
            },
            {
              "name": AppLocalizations.of(context)!.second_dropdown,
              'redirect_to': 'nowhere'
            },
          ]
        },
        {
          'title': AppLocalizations.of(context)!.help_center,
          'image': 'assets/help_center.png',
          'items': [
            {
              "name": AppLocalizations.of(context)!.first_dropdown,
              'redirect_to': 'nowhere'
            },
            {
              "name": AppLocalizations.of(context)!.second_dropdown,
              'redirect_to': 'nowhere'
            },
          ]
        },
        {
          'title': AppLocalizations.of(context)!.info,
          'image': 'assets/info.png',
          'items': [
            {
              "name": AppLocalizations.of(context)!.first_dropdown,
              'redirect_to': 'nowhere'
            },
            {
              "name": AppLocalizations.of(context)!.second_dropdown,
              'redirect_to': 'nowhere'
            },
          ]
        },
      ]
    };

    return Container(
      height: DeviceInfo(context).height,
      child: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(DeviceInfo(context).width, 100),
              child: SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 18),
                        height: 30,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: MyTheme.white,
                              size: 20,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: buildTopSection(),
                    ),
                  ],
                ),
              ),
            ),
            body: CustomScrollView(
              controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: buildSettingsSection(accountSettingsData),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: buildSettingsSection(appSettingsData),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopSection() {
    return Container(
      // color: Colors.amber,
      alignment: Alignment.center,
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: MyTheme.white, width: 1),
                //shape: BoxShape.rectangle,
              ),
              child: Row(
                children: [
                  ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      child: Image.asset('assets/user.png')),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 12),
                    child: Text(
                      'blaxk',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Image.asset(
              'assets/profile.png',
              width: 30,
            ),
            onTap: () {
              onTapLogout(context);
            },
          )
        ],
      ),
    );
  }

  Widget buildSettingsSection(data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(right: 14, left: 14, bottom: 16),
        child: Text(
          data['title'],
          style: TextStyle(fontSize: 16),
        ),
      ),
      Column(
        children: data['tabs'].map<Widget>((tab) {
          return ExpansionTile(
            title: Row(
              children: [
                Image.asset(
                  tab['image'],
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    tab['title'],
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
            iconColor: Colors.black,
            // tilePadding: EdgeInsets,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            collapsedIconColor: Colors.black,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                alignment: AlignmentDirectional.topStart,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tab['items'].map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: TextButton(
                            onPressed: () {
                              if (item['redirect_to'] == 'change_language') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChangeLanguage();
                                }));
                              }
                            },
                            child: Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )),
                      );
                    }).toList()),
              ),
            ],
          );
        }).toList(),
      )
    ]);
  }
}
