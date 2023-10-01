import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/overview_screen.dart';
import 'package:shared_pantry/screens/shopping_screen.dart';
import 'package:shared_pantry/screens/welcome_screen.dart';
import 'package:shared_pantry/widgets/pantry_scrollview.dart';
import 'package:shared_pantry/screens/profile_screen.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  static const String id = 'pantry screen';
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(initialPage: 0);
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: currentIndexNotifier,
          builder: (context, currentIndex, child) {
            return BottomNavigationBar(
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
              currentIndex: currentIndex,
              onTap: (index) {
                currentIndexNotifier.value = index;
                pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
              },
              //Needs to be linked with a provider(?)
              elevation: 6,
              backgroundColor: kColor51,
              unselectedItemColor: kColor1,
              selectedItemColor: kColor4,
            );
          }),
          body: PageView(
          controller: pageController,
          children: [
            const OverviewScreen(),
            pantryList.isNotEmpty ? PantryScrollView(currentPantry: context.watch<PantryProvider>().pantriesList[0]) : const WelcomeScreen(),
            const ShoppingScreen(),
            const ProfileScreen()
          ],
                  )
      ),
    );  }
}