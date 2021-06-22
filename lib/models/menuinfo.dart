import 'package:flutter/cupertino.dart';
import 'package:rooster/data/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String? title;
  String? imagesrc;

  MenuInfo(this.menuType, {this.title, this.imagesrc});

  updateMenu(MenuInfo menuinfo) {
    this.menuType = menuinfo.menuType;
    this.title = menuinfo.title;
    this.imagesrc = menuinfo.imagesrc;

    notifyListeners();
  }
}
