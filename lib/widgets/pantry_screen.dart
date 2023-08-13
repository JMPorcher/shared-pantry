import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/pantry_scrollview.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_pantry/widgets/profile_screen.dart';
import 'package:shared_pantry/widgets/signup_screen.dart';
import 'package:shared_pantry/widgets/welcome_screen.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final bool userIsLoggedIn = user != null;

    LoopPageController pageController =
        context.watch<PantryProvider>().pageController;
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
          if (userIsLoggedIn) {
            Navigator.pushNamed(context, ProfileScreen.id);
          } else {
            Navigator.pushNamed(context, SignupScreen.id);
          }
        }),
        // USER PRESENT? Profile screen. List all pantries with all participants. Option to delete account, thereby deleting all personal pantries and leaving shared ones.
        // NO USER? Choose user name. Does not have to be unique. Enter mobile number and wait for code. Or cancel. After code is confirmed, proceed to profile screen.
        body: pantryList.isNotEmpty
            ? LoopPageView.builder(
                controller: pageController,
                itemCount: pantryList.length,
                itemBuilder: (context, pantryIndex) {
                  Pantry currentPantry = pantryList[pantryIndex];
                  return PantryScrollView(currentPantry: currentPantry);
                })
            : const WelcomeScreen());
  }
}


