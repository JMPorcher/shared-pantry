import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/pantry.dart';

class SpCard extends StatelessWidget {
  const SpCard.text(this.cardText, {super.key})
      : pantry = null,
        isSelected = null,
        height = 75,
        onTap = null;

  const SpCard.pantry(this.pantry, {super.key, required this.onTap, this.isSelected = false})
      : cardText = null,
        height = 150;

  final String? cardText;
  final bool? isSelected;
  final double height;
  final Pantry? pantry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        child: Card(
          color: isSelected ?? false ? kColor3 : Colors.white,
          elevation: isSelected ?? false ? 0 : 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Stack(
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kColor5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cardText ?? 'Card title',
                    style: const TextStyle(color: kColor1),
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: height,
                      color: Colors.black.withOpacity(0.7),
                      width: 50,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
