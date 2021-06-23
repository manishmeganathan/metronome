import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:metronome/data/theme.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({Key? key}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  // Get Current Time Data
  var fmttime = DateFormat('h:mm').format(DateTime.now());
  var fmtmeridian = DateFormat('aa').format(DateTime.now());
  var fmtdate = DateFormat('EEEE, d MMMM y').format(DateTime.now());

  // Declare a Timer
  Timer? timer;

  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Get minute date for now and one second ago
      var prevminute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentminute = DateTime.now().minute;

      // Check if minute data has chnaged
      if (prevminute != currentminute)
        setState(() {
          // Update time data
          fmttime = DateFormat('h:mm').format(DateTime.now());
          fmtmeridian = DateFormat('aa').format(DateTime.now());
          fmtdate = DateFormat('EEEE, d MMMM y').format(DateTime.now());
        });
    });

    // Call the initState method of the super class
    super.initState();
  }

  @override
  void dispose() {
    // Stop the timer
    this.timer?.cancel();
    // Call the dispose method of the super class
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  fmttime,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 95,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  fmtmeridian,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            fmtdate,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
