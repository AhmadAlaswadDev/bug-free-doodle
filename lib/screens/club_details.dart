
import 'package:ammanauto/dummy_data/dummy_club_details.dart';
import 'package:ammanauto/dummy_data/dummy_clubs.dart';

import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/ui_elements/amman_club_card.dart';

import 'package:flutter/material.dart';
import 'package:ammanauto/helpers/shimmer_helper.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/custom/box_decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClubDetails extends StatefulWidget {
  late int club_id;
  late bool show_back_button;
  late bool go_back;

  ClubDetails({
    required this.club_id,
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _ClubDetailsState createState() => _ClubDetailsState();
}

class _ClubDetailsState extends State<ClubDetails>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _mainScrollController = ScrollController();

  late ClubDetailsItem _club_details = ClubDetailsItem(
      club: Club(club_id: 0, name: '', color: '', times: 0, duration: 0, price: 0),
      description: '',
      services: []);

  final _servicesList = [];

  bool _isClubDetailsInitial = true;

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

    _club_details = dummy_club_details
        .firstWhere((element) => element.club.club_id == widget.club_id);
    _servicesList.addAll(_club_details.services);
    _isClubDetailsInitial = false;
    setState(() {});
  }

  reset() {
    _servicesList.clear();
    _isClubDetailsInitial = true;
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
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: AmmanClubCard(
                              club: _club_details.club,
                            ),
                          )
                        ]),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1),
                                    child: Text(
                                      _club_details.club.name,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: Text(
                                      _club_details.description,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  buildServicesGrid()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration:
                                    BoxDecorations.buildBoxDecoration2(),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${ AppLocalizations.of(context)!.privecy_policies } & ${ AppLocalizations.of(context)!.terms_conditions }',
                                      style: TextStyle(
                                          color: MyTheme.red, fontSize: 16,fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('hi');
                                      },
                                      child: Image.asset(
                                        'assets/down.png',
                                        height: 24,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              child: IntrinsicWidth(
                                child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      '${ AppLocalizations.of(context)!.subscribe_with } 53%  ${ AppLocalizations.of(context)!.off }',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: MyTheme.white, fontSize: 23,fontWeight: FontWeight.bold),
                                    )),
                              )),
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

  Widget buildServicesGrid() {
    if (_isClubDetailsInitial && _servicesList.length == 0) {
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
}
