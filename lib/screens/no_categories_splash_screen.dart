import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_pantry/widgets/add_button.dart';
import 'package:shared_pantry/widgets/sp_cards.dart';

import '../models/item_category.dart';

class NoCategoriesSplashScreen extends StatelessWidget {
  const NoCategoriesSplashScreen({super.key, required this.currentCategoryList});

  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Expanded(
        child: Center(
          child: Stack(children: [
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
            ), //Image container
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: SpCard.text(
                  'This pantry has no categories yet.',
                ),
              ),
            )
          ]),
        ),
      ),
      AddButton.category(currentCategoryList: currentCategoryList)
    ]);
  }
}
