import 'package:rooster/data/enums.dart';
import 'package:rooster/models/menuinfo.dart';

List<MenuInfo> menuitems = [
  MenuInfo(MenuType.clock, title: 'Clock', imagesrc: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm, title: 'Alarm', imagesrc: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer, title: 'Timer', imagesrc: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopper,
      title: 'Stopper', imagesrc: 'assets/stopwatch_icon.png')
];
