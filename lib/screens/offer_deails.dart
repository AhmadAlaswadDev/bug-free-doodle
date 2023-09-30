import 'dart:convert';
import 'dart:typed_data';

import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/repositories/offer_repository.dart';
import 'package:ammanauto/ui_elements/amman_card.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/custom/box_decorations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfferDetails extends StatefulWidget {
  late String offer_id;
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

  var _offer_details = null;
  var _offer_amman_card = null;
  var qrCodeInfo = null;
  String rawQrCodeSvg = '';

  // details_id: 0,
  // qr_code: '',
  // amman_card:
  //     AmmanCardItem(amanauto_ms: '', vin: '', ex_date: '', color: ''),
  // details_body: ''

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
    OfferRepository().getOfferDetails(id: widget.offer_id).then((value) async {
      _offer_details = value.offer_details;
      _offer_amman_card = value.amman_card;
      rawQrCodeSvg =value.offer_details.qr_code;
      _isOfferDetailsInitial = false;
      setState(() {});
    });
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
            body: _isOfferDetailsInitial
                ? Container()
                : Stack(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Text(rawQrCodeSvg),
                                      SvgPicture.memory(base64Decode(rawQrCodeSvg),width: 80,),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 18),
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
                                  child: AmmanCard(data: _offer_amman_card),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Html(data: _offer_details.description),
                                )
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
