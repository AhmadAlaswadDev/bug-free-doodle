import 'package:ammanauto/custom/common_functions.dart';
import 'package:ammanauto/dummy_data/dummy_offers.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/offer_deails.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/custom/box_decorations.dart';

class Offers extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Offers({
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _mainScrollController = ScrollController();

  final _carouselImageList = [];
  final _offersList = [];
  bool _isOffersLayoutInitial = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
    reset();
    fetchAll();
  }

  fetchAll() {
    fetchOffersLayout();
  }

  fetchOffersLayout() async {
    _carouselImageList
        .add('http://192.168.43.103/ammanauto/guest_slider/1.png');

    if (app_language.$ == 'en') {
      _offersList.addAll(dummy_offers_list_en);
    } else {
      _offersList.addAll(dummy_offers_list_ar);
    }

    _isOffersLayoutInitial = false;
    setState(() {});
  }

  reset() {
    _carouselImageList.clear();
    _offersList.clear();
    _isOffersLayoutInitial = true;
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
                              padding: const EdgeInsets.fromLTRB(
                                18.0,
                                20.0,
                                18.0,
                                0.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.offers,
                                        style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        child: Container(
                                          child: Image.asset(
                                            "assets/settings.png",
                                            height: 32,
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: buildHomeCarouselSlider(context),
                              )
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: buildOffersForYouList(),
                              ),
                            ],
                          ),
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

  Widget buildHomeCarouselSlider(context) {
    if (_isOffersLayoutInitial && _carouselImageList.length == 0) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_carouselImageList.length > 0) {
      return CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 338 / 140,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInExpo,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current_slider = index;
              });
            }),
        items: _carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 0, bottom: 20),
                child: Stack(
                  children: <Widget>[
                    Container(
                        //color: Colors.amber,
                        width: double.infinity,
                        decoration: BoxDecorations.buildBoxDecoration_1(),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder_rectangle.jpeg',
                              image: i,
                              height: 140,
                              fit: BoxFit.cover,
                            ))),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    } else if (!_isOffersLayoutInitial && _carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.home_screen_no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildOffersForYouList() {
    if (_isOffersLayoutInitial && _offersList.isEmpty) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_offersList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
            children: _offersList.map((e) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OfferDetails(offer_id: e.offer_id);
              }));
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecorations.buildBoxDecoration2(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Text(
                              e.name,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(e.cmp_name)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              '${e.dicount_amount} % ${AppLocalizations.of(context)!.off}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: MyTheme.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Text(e.end_date),
                              Padding(
                                  padding: EdgeInsetsDirectional.only(start: 6),
                                  child: InkWell(
                                    child: Image.asset(
                                      'assets/down.png',
                                      height: 18,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        }).toList()),
      );
    } else {
      return Container(
        height: 100,
      );
    }
  }
}
