import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/pantry.dart';

class SpCard extends StatelessWidget {
  const SpCard.text(this.cardText, {super.key})
      : pantry = null,
        isSelected = null,
        height = 75,
        onTap = null,
        isInOverviewScreen = false;

  const SpCard.pantry(this.pantry,
      {super.key,
      required this.isInOverviewScreen,
      required this.onTap,
      required this.cardText,
      this.isSelected = false})
      : height = 150;

  final String? cardText;
  final bool? isSelected;
  final double height;
  final Pantry? pantry;
  final VoidCallback? onTap;
  final bool isInOverviewScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Card(
          color: isSelected ?? false ? kColor3 : Colors.white,
          elevation: isSelected ?? false ? 0 : 8.0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: CardLayoutStack(
              height: height,
              cardText: cardText,
              isInOverviewScreen:
              isInOverviewScreen,
              onTap: onTap),
        ),
      ),
    );
  }
}

class CardLayoutStack extends StatelessWidget {
  const CardLayoutStack({
    super.key,
    required this.height,
    required this.cardText,
    required this.isInOverviewScreen,
    required this.onTap,
  });

  final double height;
  final String? cardText;
  final bool isInOverviewScreen;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 30,
          bottom: 0,
          child: SizedBox(
            height: height,
            child: AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                'assets/house.svg',
                fit: BoxFit.fitHeight,
                semanticsLabel: 'House',
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
              color: kColor5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              cardText ?? 'Card title',
              style: const TextStyle(color: kColor1),
            ),
          ),
        ),
        if (isInOverviewScreen)
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  height: height,
                  width: 50,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              )
          )
      ],
    );
  }
}
