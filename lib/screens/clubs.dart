import 'package:ammanauto/custom/common_functions.dart';
import 'package:ammanauto/dummy_data/dummy_clubs.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/club_details.dart';
import 'package:ammanauto/ui_elements/amman_club_card.dart';
import 'package:ammanauto/ui_sections/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ammanauto/app_config.dart';

import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/custom/box_decorations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Clubs extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Clubs({
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _mainScrollController = ScrollController();
  final _clubsList = [];
  bool _isClubslInitial = true;

  @override
  void initState() {
    // print("app_mobile_language.en${app_mobile_language.$}");
    // print("app_language.${app_language.$}");
    // print("app_language_rtl${app_language_rtl.$}");

    // TODO: implement initState
    super.initState();
    // In initState()

    fetchAll();
  }

  fetchAll() {
    fetchClubsLayout();
  }

  fetchClubsLayout() async {
    if (app_language.$ == 'en') {
      _clubsList.addAll(dummy_clubs_list_en);
    }
    else{
      _clubsList.addAll(dummy_clubs_list_ar);
    }

    _isClubslInitial = false;

    setState(() {});
  }

  reset() {
    _clubsList.clear();
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    //print(MediaQuery.of(context).viewPadding.top);
    return WillPopScope(
      onWillPop: () async {
        CommonFunctions(context).appExitDialog();
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
              key: _scaffoldKey,
              //drawer: MainDrawer(),
              body: Stack(
                children: [
                  RefreshIndicator(
                    color: MyTheme.accent_color,
                    backgroundColor: Colors.white,
                    onRefresh: _onRefresh,
                    displacement: 0,
                    child: CustomScrollView(
                      controller: _mainScrollController,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: buildClubsList()),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    // child: buildProductLoadingContainer()
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildClubsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _clubsList.map((e) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ClubDetails(club_id: e.club_id);
            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: AmmanClubCard(
              club: e,
            ),
          ),
        );

        ;
      }).toList(),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
