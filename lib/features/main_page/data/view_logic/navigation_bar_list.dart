import 'package:flutter/material.dart';

import '../../../../resources/strings/string_keys.dart';
import 'item_bottom_navigation_bar.dart';

class NavigationBarList {
  static createNavigationBarListItem() {
    List<ItemBottomNavigationBar> navigationBar = [];
    navigationBar.add(ItemBottomNavigationBar(
      icon: Icons.translate_outlined,
      iconSelected: Icons.translate,
      label: StringKeys.translate,
    ));
    navigationBar.add(ItemBottomNavigationBar(
      icon: Icons.favorite_outlined,
      iconSelected: Icons.favorite_rounded,
      label: StringKeys.favorite,
    ));
    return navigationBar;
  }
}
