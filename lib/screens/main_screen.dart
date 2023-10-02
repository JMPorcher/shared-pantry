import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/overview_screen.dart';
import 'package:shared_pantry/screens/shopping_screen.dart';
import 'package:shared_pantry/screens/welcome_screen.dart';
import 'package:shared_pantry/screens/pantry_screen.dart';
import 'package:shared_pantry/screens/profile_screen.dart';

import '../models/pantry.dart';
import '../providers/pantry_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String id = 'pantry screen';

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(initialPage: 0);
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    int activeScreenIndex = context.watch<PantryProvider>().activeScreenIndex;
    void switchScreen(int newIndex){
      Provider.of<PantryProvider>(context, listen: false).switchActiveScreen(newIndex);
    }

    int activePantryIndex = context.watch<PantryProvider>().activePantryIndex;
    void switchPantry(int newIndex){
      Provider.of<PantryProvider>(context, listen: false).switchPantry(newIndex);
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
          BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(label: 'lol',
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_filled)),
                BottomNavigationBarItem(label: 'lol',
                    icon: Icon(Icons.summarize_outlined),
                    activeIcon: Icon(Icons.summarize)),
                BottomNavigationBarItem(label: 'lol',
                    icon: Icon(Icons.shopping_basket_outlined),
                    activeIcon: Icon(Icons.shopping_basket)),
                BottomNavigationBarItem(label: 'lol',
                    icon: Icon(Icons.account_circle_outlined),
                    activeIcon: Icon(Icons.account_circle)),
              ],
              currentIndex: activeScreenIndex,
              onTap: (index) {
                switchScreen(index);
                pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
              },
              elevation: 8,
              backgroundColor: kColor51,
              unselectedItemColor: kColor1,
              selectedItemColor: kColor4,
          ),
          body: PageView(
            onPageChanged: (index) => switchScreen(index),
          controller: pageController,
          children: [
            const OverviewScreen(),
            pantryList.isNotEmpty ? PantryScreen(currentPantry: context.watch<PantryProvider>().pantriesList[activePantryIndex]) : const WelcomeScreen(),
            const ShoppingScreen(),
            const ProfileScreen()
          ],
                  )
      ),
    );

  }
}