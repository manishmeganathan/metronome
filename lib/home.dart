import 'package:rooster/clockview.dart';
import 'package:rooster/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rooster/enums.dart';
import 'package:rooster/menuinfo.dart';
import 'package:rooster/themedata.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var fmttime = DateFormat('HH:mm').format(now);
    var fmtdate = DateFormat('EEE, d MMM').format(now);

    var timezonestring = now.timeZoneOffset.toString().split('.').first;
    var offsetsign = '';

    if (!timezonestring.startsWith('-')) offsetsign = "+";

    return Scaffold(
        backgroundColor: CustomColors.pageBackgroundColor,
        body: Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuitems
                    .map((current) => buildMenuButton(current))
                    .toList()),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 5,
            thickness: 5,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                if (value.menuType != MenuType.clock) return Container();
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text("Rooster Clock",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: CustomColors.primaryTextColor,
                                      fontSize: 20))),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(fmttime,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                CustomColors.primaryTextColor,
                                            fontSize: 64))),
                                Text(fmtdate,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                CustomColors.primaryTextColor,
                                            fontSize: 20))),
                              ]),
                        ),
                        Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: ClockView(
                                    size: MediaQuery.of(context).size.height /
                                        3))),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Timezone",
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                CustomColors.primaryTextColor,
                                            fontSize: 24))),
                                SizedBox(height: 16),
                                Row(children: [
                                  Icon(Icons.language,
                                      color: CustomColors.primaryTextColor),
                                  SizedBox(width: 16),
                                  Text("UTC" + offsetsign + timezonestring,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color:
                                                  CustomColors.primaryTextColor,
                                              fontSize: 14)))
                                ])
                              ]),
                        )
                      ],
                    ));
              },
            ),
          )
        ]));
  }

  Widget buildMenuButton(MenuInfo current) {
    return Consumer<MenuInfo>(builder: (context, value, child) {
      return TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: current.menuType == value.menuType
                ? CustomColors.menuBackgroundColor
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            var menuinfo = Provider.of<MenuInfo>(context, listen: false);
            menuinfo.updateMenu(current);
          },
          child: Column(children: <Widget>[
            Image.asset(current.imagesrc!, scale: 1.5),
            SizedBox(
              height: 10,
            ),
            Text(
              current.title!,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: current.menuType == value.menuType
                          ? CustomColors.secondaryTextColor
                          : CustomColors.primaryTextColor,
                      fontSize: 12)),
            )
          ]));
    });
  }
}
