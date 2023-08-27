import 'package:ammanauto/custom/common_functions.dart';
import 'package:ammanauto/dummy_data/dummy_offers_details.dart';
import 'package:ammanauto/dummy_data/dummy_offers_details.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/ui_elements/amman_card.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/custom/box_decorations.dart';
import 'package:flutter_html/flutter_html.dart';

class OfferDetails extends StatefulWidget {
  late int offer_id;
  late bool show_back_button;
  late bool go_back;

  OfferDetails({
    required this.offer_id,
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _mainScrollController = ScrollController();

  late Details _offer_details = Details(
      details_id: 0,
      qr_code: '',
      amman_card:
          AmmanCardItem(amanauto_ms: '', vin: '', ex_date: '', color: ''),
      details_body: '');

  bool _isOfferDetailsInitial = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()

    fetchAll();
  }

  fetchAll() {
    fetchOfferDetails();
  }

  fetchOfferDetails() async {
    _offer_details = dummy_offer_details
        .firstWhere((element) => element.details_id == widget.offer_id);
    _isOfferDetailsInitial = false;
    setState(() {});
  }

  reset() {
    _isOfferDetailsInitial = true;
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
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
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
                            padding: const EdgeInsets.fromLTRB(
                              18.0,
                              20.0,
                              18.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/qr.png',
                                  height: 80,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  child: Image.asset(
                                    'assets/card_logo2.png',
                                    height: 70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: AmmanCard(data: _offer_details.amman_card),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      'HighLights',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 12,
                                              color: MyTheme.accent_color,
                                            )),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 12,
                                              color: MyTheme.accent_color,
                                            )),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 12,
                                              color: MyTheme.accent_color,
                                            )),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      'HighLights',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 12,
                                              color: MyTheme.accent_color,
                                            )),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 12,
                                              color: MyTheme.accent_color,
                                            )),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')),
                                        ),
                                      ],
                                    ),
                                  ),
        
                                ],
                              ))
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
    );
  }
}
