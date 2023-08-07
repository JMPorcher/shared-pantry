import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/dialogs/add_pantry_dialog.dart';
import 'package:shared_pantry/widgets/pantry_scrollview.dart';
import 'package:loop_page_view/loop_page_view.dart';

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
        body: Container(
          color: Colors.blue,
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey,
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
                          fontSize: 24,
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
