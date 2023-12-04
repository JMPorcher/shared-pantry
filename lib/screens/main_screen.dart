import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/screens/overview_screen.dart';
import 'package:shared_pantry/screens/shopping_screen.dart';
import 'package:shared_pantry/screens/pantry_screen.dart';
import 'package:shared_pantry/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';
import '../widgets/sp_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String id = 'pantry screen';

  @override
  Widget build(BuildContext context) {

    final PantryProvider pantryProvider = Provider.of<PantryProvider>(context);
    final AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    final int activeScreenIndex = appStateProvider.shownScreenIndex;
    final PageController pageController = appStateProvider.mainScreenPageController;
    final List<Pantry> pantryList = pantryProvider.pantriesList;

    void switchScreen(int newIndex) async {
      appStateProvider.switchActiveScreen(newIndex);
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt('Last shown screen', activeScreenIndex);
    }

    List<Widget> buildPages() {
      if (pantryList.isNotEmpty) {
        return [
          const OverviewScreen(),
          const PantryScreen(), //currentPantry: (activePantryIndex < pantryList.length) ? pantryList[activePantryIndex] : pantryList[0]
          const ShoppingScreen(),
          ProfileScreen(),
        ];
      } else {
        return [
          const OverviewScreen(),
          ProfileScreen(),
        ];
      }
    }

    SpBottomNavigationBar buildSpBottomNavigationBar() {
      return SpBottomNavigationBar(
        items: [
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(Icons.home_outlined),
              deactivatedIcon: const Icon(Icons.home_outlined),
              active: true,
              activeIconColor: kColor4,
              selectedIcon: const Icon(Icons.home_filled)),
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(Icons.summarize_outlined),
              deactivatedIcon: Icon(Icons.summarize_outlined,
                  color: Colors.grey.shade700, size: 24),
              active: pantryList.isNotEmpty,
              activeIconColor: kColor4,
              selectedIcon: const Icon(Icons.summarize)),
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(Icons.shopping_cart_outlined),
              deactivatedIcon: Icon(Icons.shopping_cart_outlined,
                  color: Colors.grey.shade700, size: 24),
              activeIconColor: kColor3,
              active: pantryList.isNotEmpty,
              selectedIcon: const Icon(Icons.shopping_cart)),
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(
                Icons.account_circle_outlined,
              ),
              deactivatedIcon: const Icon(Icons.account_circle_outlined),
              active: true,
              activeIconColor: kColor4,
              selectedIcon: const Icon(Icons.account_circle)),
        ],
        currentIndex: pantryList.isNotEmpty
            ? activeScreenIndex
            : activeScreenIndex == 0
            ? 0
            : 3,
        onTap: (index) {
          if (pantryList.isNotEmpty) {
            switchScreen(index);
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          } else {
            if (index == 0 || index == 3) {
              switchScreen(index);
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
          }
        },
      );
    }

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: buildSpBottomNavigationBar(),
          body: PageView(
              onPageChanged: (index) => switchScreen(index),
              controller: pageController,
              children: buildPages()),
      )
    );
  }
}
