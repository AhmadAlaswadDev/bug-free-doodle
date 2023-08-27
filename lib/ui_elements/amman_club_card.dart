import 'package:ammanauto/dummy_data/dummy_clubs.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:ammanauto/app_config.dart';
// import 'package:al_ruayah_al_thakiah_eng/custom/box_decorations.dart';
// import 'package:al_ruayah_al_thakiah_eng/screens/product_details.dart';

class AmmanClubCard extends StatefulWidget {
  // List card;
  Club club;

   AmmanClubCard({
    Key? key,
    // required this.card,
    required this.club,
  }) : super(key: key);

  @override
  _AmmanClubCardState createState() => _AmmanClubCardState();
}

class _AmmanClubCardState extends State<AmmanClubCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            height: 196,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: _colorFromHex(widget.club.color)),
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
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.club.name,
                                  style: TextStyle(
                                      color: MyTheme.white, fontSize: 35,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(AppLocalizations.of(context)!.times,
                                    style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                Text(
                                  ' : ${widget.club.times == 999 ? AppLocalizations.of(context)!.unlimited_times : widget.club.times.toString()} ',
                                  style: TextStyle(color: MyTheme.white,fontSize: 16,fontWeight: FontWeight.bold ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(AppLocalizations.of(context)!.duration,
                                    style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                Text(
                                    ' : ${widget.club.duration.toString()} ',
                                  style: TextStyle(
                                      color: MyTheme.white,fontSize: 16,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Text(
                            '${widget.club.price.toString()} ${AppLocalizations.of(context)!.sar}',
                            style:
                                TextStyle(color: MyTheme.white, fontSize: 30 ,fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                                            Transform(
                        alignment: Alignment.center,
                        transform: app_language_rtl.$ ? Matrix4.rotationY(3.1415926535897932) : Matrix4.rotationY(0)  ,
                        child: Image.asset('assets/card_side.png'),
                      )],
                  )
                ],
              ),
            )));
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
