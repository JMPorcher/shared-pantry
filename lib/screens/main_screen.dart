import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/overview_screen.dart';
import 'package:shared_pantry/screens/shopping_screen.dart';
import 'package:shared_pantry/widgets/pantry_scrollview.dart';
import 'package:shared_pantry/screens/profile_screen.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String id = 'pantry screen';

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(initialPage: 0);
    Pantry currentPantry = context.watch<PantryProvider>().pantriesList[0];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(icon: Icon(Icons.summarize_outlined), activeIcon: Icon(Icons.summarize)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), activeIcon: Icon(Icons.shopping_basket)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), activeIcon: Icon(Icons.account_circle)),
        ],
        elevation: 6,
        backgroundColor: kColor51,
        unselectedItemColor: kColor1,
        selectedItemColor: kColor4,
      ),
        body: PageView(
        controller: pageController,
        children: [
          const OverviewScreen(),
          PantryScrollView(currentPantry: currentPantry),
          const ShoppingScreen(),
          const ProfileScreen()
        ],
                )
    );  }
}

//TODO Bottom navigation bar
