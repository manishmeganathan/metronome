import 'package:flutter/material.dart';
import 'package:rooster/data/enums.dart';
import 'package:rooster/views/home.dart';
import 'package:provider/provider.dart';
import 'package:rooster/models/menuinfo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
          create: (context) => MenuInfo(MenuType.clock), child: Home()),
    );
  }
}
