import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metronome/widgets/menubuttons.dart';
import 'package:metronome/screens/homepage.dart';

void main() {
  runApp(Metronome());
}

class Metronome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metronome',
      home: ChangeNotifierProvider<MenuButton>(
          create: (context) => MenuButton(MenuIcon.clock, "Clock"),
          child: Home()),
    );
  }
}
