import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/models/item_category.dart';
import 'package:shared_pantry/widgets/no_categories_splash.dart';
import 'package:shared_pantry/widgets/sp_card.dart';

import '../dialogs/add_category_dialog.dart';
import '../models/pantry.dart';
import '../widgets/category_expansion_tile.dart';

class PantryPage extends StatelessWidget {

  PantryPage({super.key, required this.pantry
  });

  final Pantry pantry;
  late List<ItemCategory> categoryList;

  @override
  Widget build(BuildContext context) {
    categoryList = pantry.categories;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            pantry: pantry,
          ),
        ),
        if (pantry.categories.isEmpty)
          NoCategoriesSplashView(pantry)
        else
          buildCategories(categoryList),
      ],
    ));
  }

  SliverList buildCategories(List<ItemCategory> categoryList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        {
          if (index < categoryList.length) {
            ItemCategory currentCategory = categoryList[index];
            return CategoryExpansionTile(pantry, currentCategory);
          } else {
            return AddCategoryButton(pantry);
          }
        }
      }, childCount: categoryList.length + 1),
    );
  }
}

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton(this.pantry, {super.key});
  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
          child: SizedBox(
            height: 68,
            width: double.infinity,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: kColor12,
                elevation: 0,
                child:
                    const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Add a category',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16)),
                  Icon(Icons.add, size: 24)
                ])),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AddCategoryDialog(pantry));
          }),
    );
  }
}

class NoCategoriesSplashView extends StatelessWidget {
  const NoCategoriesSplashView(this.pantry, {
    super.key
  });

  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const NoCategoriesSplashScreen(),
            AddCategoryButton(pantry),
          ]),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.pantry});

  final Pantry pantry;
  final double maxHeight = 200;
  final double minHeight = 64;

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
            ]))),
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
