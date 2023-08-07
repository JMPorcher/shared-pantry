import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/dialogs/add_pantry_dialog.dart';
import 'package:shared_pantry/widgets/pantry_scrollview.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_pantry/widgets/profile_screen.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoopPageController pageController =
        context.watch<PantryProvider>().pageController;
    List<Pantry> pantryList = context.watch<PantryProvider>().pantriesList;

    if (pantryList.isNotEmpty) {
      return LoopPageView.builder(
          controller: pageController,
          itemCount: pantryList.length,
          itemBuilder: (context, pantryIndex) {
            Pantry currentPantry = pantryList[pantryIndex];

            return PantryScrollView(currentPantry: currentPantry);
          });
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () { Navigator.pushNamed(context, ProfileScreen.id); }), //TODO Build a floating action button
        //Start sign-up process
        //Full new screen.
        // USER PRESENT? Profile screen. List all pantries with all participants. Option to delete account, thereby deleting all personal pantries and leaving shared ones.
        // NO USER? Choose user name. Does not have to be unique. Enter mobile number and wait for code. Or cancel. After code is confirmed, proceed to profile screen.

        body: Container(
          color: Colors.white,
          child: Center(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(32),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: SvgPicture.asset(
                        'assets/pantry_welcome.svg',
                        semanticsLabel: 'Food pantry',
                      ),
                    ),
                  ),
                ),//Image container
                Positioned.fill(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddPantryDialog(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: kColor5,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 5,
                            color: Colors.black26,
                          )
                        ],
                      ),
                      child: const Text(
                        'Add your first pantry',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),//Add Pantry button
              ],
            ),
          ),
        ),
      );
    }
  }
}
