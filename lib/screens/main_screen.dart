// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/overview_screen.dart';
import 'package:shared_pantry/screens/shopping_screen.dart';
import 'package:shared_pantry/screens/no_pantries_splash_screen.dart';
import 'package:shared_pantry/screens/pantry_screen.dart';
import 'package:shared_pantry/screens/profile_screen.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';
import '../widgets/sp_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String id = 'pantry screen';

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: 0); //TODO Save index in Shared Preferences
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    int activeScreenIndex = context.watch<PantryProvider>().shownScreenIndex;

    void switchScreen(int newIndex) {
      Provider.of<PantryProvider>(context, listen: false)
          .switchActiveScreen(newIndex);
    }

    int activePantryIndex = context.watch<PantryProvider>().selectedPantryIndex;

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: SpBottomNavigationBar(
            items: [
              SpBottomNavigationBarItem(
                  label: 'lol',
                  activatedIcon: const Icon(Icons.home_outlined),
                  deactivatedIcon: const Icon(Icons.home_outlined),
                  active: true,
                  activeIconColor: kColor4,
                  selectedIcon: const Icon(Icons.home_filled)),
              SpBottomNavigationBarItem(
                  label: 'lol',
                  activatedIcon: const Icon(Icons.summarize_outlined),
                  deactivatedIcon: Icon(Icons.summarize_outlined,
                      color: Colors.grey.shade700),
                  active: pantryList.isNotEmpty,
                  activeIconColor: kColor4,
                  selectedIcon: const Icon(Icons.summarize)),
              SpBottomNavigationBarItem(
                  label: 'lol',
                  activatedIcon: const Icon(Icons.shopping_cart_outlined),
                  deactivatedIcon: Icon(Icons.shopping_cart_outlined,
                      color: Colors.grey.shade700),
                  activeIconColor: kColor3,
                  active: pantryList.isNotEmpty,
                  selectedIcon: const Icon(Icons.shopping_cart)),
              SpBottomNavigationBarItem(
                  label: 'lol',
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
          ),
          body: PageView(
              onPageChanged: (index) => switchScreen(index),
              controller: pageController,
              children: pantryList.isNotEmpty
                  ? [
                      OverviewScreen(pageController),
                      PantryScreen(
                          currentPantry: context
                              .watch<PantryProvider>()
                              .pantriesList[activePantryIndex]),
                      //TODO Replace choice by index with choice through identity. Why again?
                      const ShoppingScreen(),
                      const ProfileScreen()
                    ]
                  : [const NoPantriesSplashScreen(), const ProfileScreen()])),
    );
  }
}
