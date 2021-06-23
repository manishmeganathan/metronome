import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class MenuIcon {
  late IconData active;
  late IconData inactive;

  MenuIcon(this.active, this.inactive);

  static MenuIcon todo = MenuIcon(Mdi.checkCircleOutline, Mdi.checkCircle);
  static MenuIcon alarm = MenuIcon(Mdi.bellRingOutline, Mdi.bellRing);
  static MenuIcon clock = MenuIcon(Mdi.clockOutline, Mdi.clock);
  static MenuIcon stop = MenuIcon(Mdi.timerOutline, Mdi.timer);
  static MenuIcon timer = MenuIcon(Mdi.timerSandEmpty, Mdi.timerSandFull);
}

class MenuButton extends ChangeNotifier {
  MenuIcon menu;
  String title;

  MenuButton(this.menu, this.title);

  updateMenu(MenuButton newmenu) {
    this.menu = newmenu.menu;
    this.title = newmenu.title;

    notifyListeners();
  }
}

List<MenuButton> menuitems = [
  MenuButton(MenuIcon.alarm, 'Alarm'),
  MenuButton(MenuIcon.todo, 'Todo'),
  MenuButton(MenuIcon.clock, 'Clock'),
  MenuButton(MenuIcon.stop, 'Stop'),
  MenuButton(MenuIcon.timer, 'Timer'),
];
