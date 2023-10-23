import 'package:flutter/material.dart';

import '../constants.dart';

class SpBottomNavigationBar extends StatefulWidget {
  const SpBottomNavigationBar(
      {super.key, required this.items, required this.currentIndex, this.onTap});

  final List<SpBottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;

  @override
  State<SpBottomNavigationBar> createState() => _SpBottomNavigationBarState();
}

class _SpBottomNavigationBarState extends State<SpBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        items: widget.items.map((item) {
            return BottomNavigationBarItem(
                label: item.label,
                icon: item.active ? item.activatedIcon : item.deactivatedIcon,
              activeIcon: item.selectedIcon
            );
          }).toList(),
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      elevation: 8,
      backgroundColor: kColor51, // Customize as needed
      unselectedItemColor: kColor1, // Customize as needed
      selectedItemColor: kColor4, // Customize as needed
    );

  }
}

class SpBottomNavigationBarItem {
  final String label;
  final Icon activatedIcon;
  final Icon deactivatedIcon;
  final Icon selectedIcon;
  final Color activeIconColor;
  final bool active;

  SpBottomNavigationBarItem( {
    required this.label,
    required this.activatedIcon,
    required this.deactivatedIcon,
    required this.selectedIcon,
    required this.activeIconColor,
    required this.active,
  });
}
