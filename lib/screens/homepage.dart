import 'package:flutter/material.dart';
import 'package:metronome/screens/clockpage.dart';
import 'package:provider/provider.dart';
import 'package:metronome/data/theme.dart';
import 'package:metronome/widgets/menubuttons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                menuitems.map((menuitem) => buildMenuButton(menuitem)).toList(),
          ),
          SizedBox(height: 25),
          Expanded(
            child: Consumer<MenuButton>(
              builder: (context, value, child) {
                if (value.menu == MenuIcon.clock)
                  return ClockPage();
                else
                  return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuButton currentmenu) {
    return Consumer<MenuButton>(
      builder: (context, value, child) {
        var icondata = value.menu == currentmenu.menu
            ? currentmenu.menu.active
            : currentmenu.menu.inactive;

        var iconcolor =
            value.menu == currentmenu.menu ? AppColors.blue : AppColors.grey;

        var shadowcolor = value.menu == currentmenu.menu
            ? AppColors.blue
            : Colors.transparent;

        return ElevatedButton(
          onPressed: () {
            var menubutton = Provider.of<MenuButton>(context, listen: false);
            menubutton.updateMenu(currentmenu);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            enableFeedback: true,
            elevation: MaterialStateProperty.all<double>(10),
            shadowColor: MaterialStateProperty.all<Color>(shadowcolor),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          child: Icon(
            icondata,
            size: 30,
            color: iconcolor,
          ),
        );
      },
    );
  }
}
