import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/pantry.dart';

class SpCard extends StatelessWidget {
  const SpCard(this.pantry,
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
  final VoidCallback onTap;
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: CardLayoutStack(
              height: height,
              cardText: cardText,
              isInOverviewScreen: isInOverviewScreen,
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
        PositionedBackgroundImage(height: height),
        TitleContainer(cardText: cardText),
        isInOverviewScreen
            ? GoToPantryButton(onTap: onTap, height: height)
            : EditPantryButton(onTap: onTap)
      ],
    );
  }
}

class EditPantryButton extends StatelessWidget {
  const EditPantryButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        top: 0,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                color: kColor5),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.settings,
              size: 24,
              color: kColor1,
            ),
          ),
        ));
  }
}

class GoToPantryButton extends StatelessWidget {
  const GoToPantryButton({
    super.key,
    required this.onTap,
    required this.height,
  });

  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
        ));
  }
}

class TitleContainer extends StatelessWidget {
  const TitleContainer({
    super.key,
    required this.cardText,
  });

  final String? cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
          color: kColor5),
      padding: const EdgeInsets.all(12),
      child: Text(
        cardText ?? 'Card title',
        style: const TextStyle(color: kColor1, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class PositionedBackgroundImage extends StatelessWidget {
  const PositionedBackgroundImage({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
