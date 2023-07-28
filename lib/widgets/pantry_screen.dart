import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/dialogs/add_pantry_dialog.dart';
import 'package:shared_pantry/widgets/pantry_scrollview.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../models/pantry.dart';
import '../providers/pantry_list_provider.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
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
            body: SafeArea(
              child: Center(
                  child: Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/pantry_welcome.svg',
                          semanticsLabel: 'Food pantry',),
                        Center(
                          child: MaterialButton(
                            onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AddPantryDialog());
                              },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [BoxShadow(
                                      offset: Offset(3, 3),
                                      blurStyle: BlurStyle.normal,
                                      blurRadius: 5)]
                              ),
                              child: const Text(
                                  'Add your first pantry',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        )]
                  )
                ),
              ),
          );
    }
  }
}
