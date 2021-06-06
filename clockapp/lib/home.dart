import 'package:clockapp/clockview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Color(0xFF2D2F41),
        body: Row(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildMenuButton('Clock', 'assets/clock_icon.png'),
              buildMenuButton('Alarm', 'assets/alarm_icon.png'),
              buildMenuButton('Timer', 'assets/timer_icon.png'),
              buildMenuButton('Stopwatch', 'assets/stopwatch_icon.png')
            ],
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 2,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text("Clock",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fmttime,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 64))),
                            Text(fmtdate,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20))),
                          ]),
                    ),
                    Flexible(
                        flex: 6,
                        fit: FlexFit.tight,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: ClockView(size: MediaQuery.of(context).size.height / 3))),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Timezone",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 24))),
                            SizedBox(height: 16),
                            Row(children: [
                              Icon(Icons.language, color: Colors.white),
                              SizedBox(width: 16),
                              Text("UTC" + offsetsign + timezonestring,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 14)))
                            ])
                          ]),
                    )
                  ],
                )),
          )
        ]));
  }

  Padding buildMenuButton(String title, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton(
          onPressed: () {},
          child: Column(children: <Widget>[
            Image.asset(image, scale: 1.5),
            Text(
              title,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.white, fontSize: 14)),
            )
          ])),
    );
  }
}
