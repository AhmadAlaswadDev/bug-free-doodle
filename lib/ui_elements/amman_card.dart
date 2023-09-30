import 'package:ammanauto/dummy_data/dummy_offers_details.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/models/offers/offer_details_response.dart';
import 'package:flutter/material.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:ammanauto/app_config.dart';
// import 'package:al_ruayah_al_thakiah_eng/custom/box_decorations.dart';
// import 'package:al_ruayah_al_thakiah_eng/screens/product_details.dart';

class AmmanCard extends StatefulWidget {
  // List card;
  AmmanCardItem data;

  AmmanCard({
    Key? key,
    // required this.card,
    required this.data,
  }) : super(key: key);

  @override
  _AmmanCardState createState() => _AmmanCardState();
}

class _AmmanCardState extends State<AmmanCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 196, // minimum height
            ),
            child: Container(
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: _colorFromHex(widget.data.color)),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 16, bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amanauto MS',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        child: Text(
                                          ' : ${widget.data.amanauto_ms}',
                                          style: TextStyle(
                                              color: MyTheme.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('VIN',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      ' : ${widget.data.vin}',
                                      style: TextStyle(
                                          color: MyTheme.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLocalizations.of(context)!.ex_date,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      ' : ${widget.data.ex_date}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyTheme.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Image.asset(
                              'assets/card_logo.png',
                              width: 80,
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: app_language_rtl.$
                                ? Matrix4.rotationY(3.1415926535897932)
                                : Matrix4.rotationY(0),
                            child: Image.asset(
                              'assets/card_side.png',
                              height: 124,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))));
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
