import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/dialogs/edit_pantry_dialog.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';
import 'package:shared_pantry/widgets/no_categories_splash.dart';
import 'package:shared_pantry/widgets/sp_card.dart';

import '../dialogs/add_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/buttons.dart';
import '../widgets/category_expansion_tile.dart';

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PantryProvider pantryProvider = context.watch<PantryProvider>();
    final AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    final currentPantryIndex = appStateProvider.selectedPantryIndex;
    final currentPantry = pantryProvider.pantriesList[currentPantryIndex];
    final currentCategoryList = currentPantry.categories;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
              minHeight: 64,
              maxHeight: 200,
              pantry: currentPantry,
          ),
        ),
        if (currentCategoryList.isEmpty)
          NoCategoriesSplashView(currentCategoryList: currentCategoryList)
        else
          buildCategories(currentCategoryList),
      ],
    ));
  }

  SliverList buildCategories(List<ItemCategory> currentCategoryList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        {
          if (index < currentCategoryList.length) {
            ItemCategory currentCategory = currentCategoryList[index];
            return CategoryExpansionTile(currentCategory,
                itemCategoryList: currentCategoryList);
          } else {
            return AddCategoryButton(currentCategoryList);
          }
        }
      }, childCount: currentCategoryList.length + 1),
    );
  }
}

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton(
    this.currentCategoryList, {
    super.key,
  });

  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {
    return SpButton.filledButton(
        child: const Text('Add a category', style: kFilledButtonTextStyle),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AddCategoryDialog(currentCategoryList));
        });
  }
}

class NoCategoriesSplashView extends StatelessWidget {
  const NoCategoriesSplashView({
    super.key,
    required this.currentCategoryList,
  });

  final List<ItemCategory> currentCategoryList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const NoCategoriesSplashScreen(),
            AddCategoryButton(currentCategoryList),
          ]),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Pantry pantry;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.pantry,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              stops: const [
                0.6,
                1
              ],
              colors: [
                kColor1,
                kColor1.withOpacity(0.1),
              ]
            )
          )),
          PantryScreenCard(pantry),
      ],
    );
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
