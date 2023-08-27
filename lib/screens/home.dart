import 'package:ammanauto/custom/common_functions.dart';
import 'package:ammanauto/dummy_data/dummy_offers.dart';
import 'package:ammanauto/dummy_data/dummy_offers_details.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/screens/offer_deails.dart';
import 'package:ammanauto/screens/profile.dart';
import 'package:ammanauto/ui_elements/amman_card.dart';
import 'package:ammanauto/ui_sections/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ammanauto/app_config.dart';

import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/custom/box_decorations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Home({
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _mainScrollController = ScrollController();

  bool _isHomeLayoutInitial = true;
  final _offerssList = [];

  @override
  void initState() {
    // print("app_mobile_language.en${app_mobile_language.$}");
    // print("app_language.${app_language.$}");
    // print("app_language_rtl${app_language_rtl.$}");

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
    if (app_language.$ == 'en') {
      for (var i = 0; i < dummy_offers_list_en.length; i++) {
        if (i < 3) {
          _offerssList.add(dummy_offers_list_en[i]);
        }
      }
    } else {
      for (var i = 0; i < dummy_offers_list_ar.length; i++) {
        if (i < 3) {
          _offerssList.add(dummy_offers_list_ar[i]);
        }
      }
    }

    _isHomeLayoutInitial = false;
    setState(() {});
  }

  reset() {
    _offerssList.clear();
    _isHomeLayoutInitial = true;
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
                                20.0,
                                60.0,
                                20.0,
                                6.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${AppLocalizations.of(context)!.hi}, Blaxk',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Image.asset(
                                              "assets/waving_hand.png",
                                              height: 34,
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        child: Container(
                                          child: Image.asset(
                                            "assets/profile_2.png",
                                            height: 42,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile()));
                                        },
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
                                child: AmmanCard(
                                    data: AmmanCardItem(
                                        amanauto_ms: '456789784',
                                        vin: 'W323FEG42311',
                                        ex_date: '12 / 4 / 2024',
                                        color: '#1fadc6')),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .services,
                                                  style: const TextStyle(
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold ),
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 6),
                                                        child: Image.asset(
                                                          "assets/phone_circle.png",
                                                          height: 42,
                                                        ),
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                    Text(
                                                      'Call For Service',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: MyTheme.red),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                    buildServicesList()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .offers_for_you,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                    buildOffersForYouList()
                                  ],
                                ),
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

  Widget buildServicesList() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.3, color: MyTheme.medium_grey))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            'Flat Tire',
                            style: TextStyle(
                                color: MyTheme.accent_color,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Text('Today - 18:21')
                      ],
                    ),
                    const Text(
                      'Open',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget buildOffersForYouList() {
    if (_isHomeLayoutInitial && _offerssList.isEmpty) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_offerssList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
            children: _offerssList.map((e) {
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
                                    fontSize: 16,
                                    color: MyTheme.accent_color,
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
                                    color: MyTheme.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Text(e.end_date),
                                Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 6),
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
                  )));
        }).toList()),
      );
    } else {
      return Container(
        height: 100,
      );
    }

    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   child: Column(
    //     children: [
    //       Container(
    //           padding: const EdgeInsets.symmetric(vertical: 6),
    //           decoration: BoxDecorations.buildBoxDecoration2(),
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(bottom: 3),
    //                       child: Text(
    //                         'Car wash',
    //                         style: TextStyle(
    //                             color: MyTheme.accent_color,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                     const Text('petirmin company')
    //                   ],
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(bottom: 8),
    //                       child: Text(
    //                         '50% OFF',
    //                         style: TextStyle(
    //                             color: MyTheme.red,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                     const Text('End : 20 / 12 / 2023')
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ))
    //     ],
    //   ),
    // );
  }
}
