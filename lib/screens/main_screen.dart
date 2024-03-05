import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/screens/overview_page.dart';
import 'package:shared_pantry/screens/shopping_page.dart';
import 'package:shared_pantry/screens/pantry_page.dart';
import 'package:shared_pantry/screens/profile_page.dart';
import '../models/pantry.dart';
import '../widgets/sp_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String id = 'main screen';

  @override
  Widget build(BuildContext context) {
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final int activeScreenIndex = appStateProvider.shownScreenIndex;
    final PageController pageController =
        appStateProvider.mainScreenPageController;
    final pantries = context.watch<List<Pantry>>();
    final Pantry activePantry = (pantries.isNotEmpty)
        ? pantries.firstWhere(
            (pantry) => pantry.id == appStateProvider.selectedPantryId,
            orElse: () => pantries[0])
        : Pantry(moderatorIds: [], title: '', id: '', founderID: '');

    print(activePantry.id);
    print('No of pantries: ${pantries.length}');

    void switchScreen(int newIndex) async {
      appStateProvider.switchActiveScreen(newIndex);
    }

    List<Widget> buildPages() {
      if (pantries.isNotEmpty) {
        return [
          const OverviewPage(),
          PantryPage(pantry: activePantry),
          //TODO Make sure last shown pantry is shown
          const ShoppingPage(),
          ProfilePage(),
        ];
      } else {
        return [
          const OverviewPage(),
          ProfilePage(),
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
              selectedIcon: const Icon(Icons.home)),
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(Icons.summarize_outlined),
              deactivatedIcon: Icon(Icons.summarize_outlined,
                  color: Colors.grey.shade700, size: 24),
              active: pantries.isNotEmpty,
              activeIconColor: kColor4,
              selectedIcon: const Icon(Icons.summarize)),
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(Icons.shopping_cart_outlined),
              deactivatedIcon: Icon(Icons.shopping_cart_outlined,
                  color: Colors.grey.shade700, size: 24),
              activeIconColor: kColor3,
              active: pantries.isNotEmpty,
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
        currentIndex: pantries.isNotEmpty
            ? activeScreenIndex
            : activeScreenIndex == 0
                ? 0
                : 3,
        onTap: (index) {
          if (pantries.isNotEmpty || index == 0 || index == 3) {
            appStateProvider.switchActiveScreen(index);
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
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
    ));
  }
}
