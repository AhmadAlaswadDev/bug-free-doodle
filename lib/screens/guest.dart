import 'package:ammanauto/custom/common_functions.dart';
import 'package:ammanauto/dummy_data/dummy_subscription_steps.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/login.dart';
import 'package:ammanauto/ui_sections/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ammanauto/app_config.dart';

import 'package:ammanauto/dummy_data/dummy_entities.dart';
import 'package:ammanauto/dummy_data/dummey_services.dart';

import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ammanauto/custom/box_decorations.dart';

class Guest extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Guest({
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  final _carouselImageList = [];
  final _entitiesList = [];
  final _servicesList = [];
  final _subsription_steps_List = [];

  final ScrollController _mainScrollController = ScrollController();
  bool _isCarouselInitial = true;
  bool _isGusetLayoutInitial = true;

// _isCarouselInitial && _carouselImageList.length == 0

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
    fetchGuestLayout();
  }

  fetchGuestLayout() async {
    _carouselImageList
        .add('http://192.168.43.103/ammanauto/guest_slider/1.png');
    _isCarouselInitial = false;

    _entitiesList.addAll(dummy_entities_list);
    if (app_language.$ == 'en') {
      _servicesList.addAll(dummy_services_list_en);
    _subsription_steps_List.addAll(dummy_subsription_steps_list_en);
    } else {
      _servicesList.addAll(dummy_services_list_ar);
       _subsription_steps_List.addAll(dummy_subsription_steps_list_ar);
    }
    _isGusetLayoutInitial = false;

    setState(() {});
  }

  reset() {
    _carouselImageList.clear();
    _entitiesList.clear();
    _servicesList.clear();
    _subsription_steps_List.clear();
    _isGusetLayoutInitial = false;
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
              backgroundColor: Colors.white,
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
                                60.0,
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
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .hi_guest,
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
                                                      Login()));
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .entities_we_happy_to_serve_with,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    buildEntitiesGrid()
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .various_services_secure_you_way,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    buildServicesGrid()
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .subscreption_steps,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    buildSubsriptionsGrid()
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .common_qusetions,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    buildCommonQuestions()
                                  ],
                                ),
                              )
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
    if (_isCarouselInitial && _carouselImageList.length == 0) {
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
                              placeholder: 'assets/data/guest_slider/1.png',
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
    } else if (!_isCarouselInitial && _carouselImageList.length == 0) {
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

  Widget buildEntitiesGrid() {
    if (_isGusetLayoutInitial && _entitiesList.isEmpty) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_entitiesList.isNotEmpty) {
      return GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 10, left: 18, right: 18),
        physics: const NeverScrollableScrollPhysics(),
        children: _entitiesList.map((e) {
          return Container(
            //color: Colors.amber,
            width: 68,
            height: 40,
            decoration: BoxDecorations.buildBoxDecoration(),
            child: Container(
                alignment: Alignment.center, // use aligment
                child: Image.asset(e.photo, height: 28, fit: BoxFit.cover)),
          );
        }).toList(),
      );
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildServicesGrid() {
    if (_isGusetLayoutInitial && _servicesList.length == 0) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_servicesList.isNotEmpty) {
      return Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(top: 20.0, bottom: 10, left: 18, right: 18),
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.4),
          children: _servicesList.map((e) {
            return Container(
                //color: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecorations.buildBoxDecoration2(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.center, // use aligment
                          child: Image.asset(e.photo,
                              height: 40, fit: BoxFit.cover)),
                      Text(
                        e.name,
                        style: TextStyle(
                            fontSize: 10, color: MyTheme.accent_color),
                      )
                    ]));
          }).toList(),
        ),
      );
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildSubsriptionsGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _subsription_steps_List.map((e) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center, // use aligment
                    padding: EdgeInsets.only(bottom: 10),
                    child:
                        Image.asset(e.photo, height: 50, fit: BoxFit.cover)),
                Text(
                  e.name,
                  style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
                )
              ],
            ));
      }).toList(),
    );
  }

  buildCommonQuestions() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: MyTheme.accent_color)),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ExpansionTile(
              title: const Text(
                'What is the way to participate.',
                style: TextStyle(fontSize: 14),
              ),
              iconColor: MyTheme.accent_color,
              // tilePadding: EdgeInsets,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              collapsedIconColor: MyTheme.accent_color,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  alignment: AlignmentDirectional.topStart,
                  child: const Text(
                      'Lorem ipsum dolor sit amet. Ex quia nihil et quia consequuntur et fugit blanditiis aut illo illum est impedit voluptatem. Est consequatur repudiandae in odit ipsa qui provident sunt ea beatae sunt ut magnam internos qui galisum doloribus. Qui facere ipsa vel necessitatibus quibusdam eum provident consequuntur ad suscipit fuga?'),
                ),
              ],
            )));
  }
}
