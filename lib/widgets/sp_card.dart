import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_pantry/widgets/buttons.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';
import '../dialogs/edit_pantry_dialog.dart';
import '../models/pantry.dart';

class OverviewScreenCard extends StatelessWidget {
  const OverviewScreenCard(
      {super.key,
      required this.isSelected,
      required this.title});

  final bool? isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          color: isSelected ?? false ? kColor3 : Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child:
              _OverviewCardLayoutStack(cardText: title),
        ),
      ),
    );
  }
}

class _OverviewCardLayoutStack extends StatelessWidget {
  const _OverviewCardLayoutStack({
    required this.cardText
  });

  final String? cardText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _OverviewCardBackgroundImage(),
        TitleContainer(cardText: cardText),
      ],
    );
  }
}

class _OverviewCardBackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      bottom: 0,
      child: SizedBox(
        height: 150,
        child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/house.svg',
                  fit: BoxFit.fitHeight,
                  semanticsLabel: 'House',
                ),
                //if (isAddButton) Container(color: Colors.white.withOpacity(0.7),)
              ],
            )),
      ),
    );
  }
}

class AddPantryCard extends StatelessWidget {
  const AddPantryCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: GestureDetector(
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => AddPantryDialog()),
          child: Card(
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: _AddPantryCardStack(),
          ),
        ),
      ),
    );
  }
}


class _AddPantryCardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: SvgPicture.asset(
                  'assets/pantry_welcome.svg',
                  fit: BoxFit.fitWidth,
                  semanticsLabel: 'Pantry image',
                ),
              ),
              Container(color: Colors.white.withOpacity(0.7)),
              SpButton.filledButton(
                  fillColor: Colors.grey,
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => AddPantryDialog()),
                  child: const Text('Add new pantry', style: kFilledButtonTextStyle))
            ],
          )),
    );
  }
}

class PantryScreenCard extends StatelessWidget {
  const PantryScreenCard(this.pantry, {super.key});

  final Pantry pantry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          elevation: 8.0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: _PantryScreenCardLayoutStack(pantry),
        ),
      ),
    );
  }
}

class _PantryScreenCardLayoutStack extends StatefulWidget {
  const _PantryScreenCardLayoutStack(this.pantry);

  final Pantry pantry;

  @override
  State<_PantryScreenCardLayoutStack> createState() => _PantryScreenCardLayoutStackState();
}

class _PantryScreenCardLayoutStackState extends State<_PantryScreenCardLayoutStack> {

  @override
  void didUpdateWidget(covariant _PantryScreenCardLayoutStack oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _OverviewCardBackgroundImage(),
        TitleContainer(cardText: widget.pantry.title),
        EditPantryButton(
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => EditPantryDialog(
                      widget.pantry,
                    )))
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
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(12)),
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
