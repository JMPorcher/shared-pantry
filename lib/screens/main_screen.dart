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

  static const String id = 'pantry screen';

  @override
  Widget build(BuildContext context) {
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final int activeScreenIndex = appStateProvider.shownScreenIndex;
    final PageController pageController = appStateProvider.mainScreenPageController;
    // ignore: unused_local_variable
    final pantryProviders = Provider.of<List<Stream<Pantry>>>(context);

    print('No. of streamed pantry Ids (main screen): ${pantryProviders.length}');

    void switchScreen(int newIndex) async {
      appStateProvider.switchActiveScreen(newIndex);
    }

    List<Widget> buildPages() {
      if (pantryProviders.isNotEmpty) {
        return [
          const OverviewPage(),
          const PantryPage(
          //    pantryProvider: pantryProviders[0]
          ),//TODO Make sure last shown pantry is shown
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
              active: pantryProviders.isNotEmpty,
              activeIconColor: kColor4,
              selectedIcon: const Icon(Icons.summarize)),
          SpBottomNavigationBarItem(
              activatedIcon: const Icon(Icons.shopping_cart_outlined),
              deactivatedIcon: Icon(Icons.shopping_cart_outlined,
                  color: Colors.grey.shade700, size: 24),
              activeIconColor: kColor3,
              active: pantryProviders.isNotEmpty,
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
        currentIndex: pantryProviders.isNotEmpty
            ? activeScreenIndex
            : activeScreenIndex == 0
            ? 0
            : 3,
        onTap: (index) {
          if (pantryProviders.isNotEmpty || index == 0 || index == 3) {
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
          )
        );
  }
}
