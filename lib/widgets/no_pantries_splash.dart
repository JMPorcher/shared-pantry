import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_pantry/widgets/buttons.dart';

import '../dialogs/add_pantry_dialog.dart';

class NoPantriesSplash extends StatelessWidget {
  const NoPantriesSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgStack(),
          AddFirstPantryButton()
        ]);
  }
}

class SvgStack extends StatelessWidget {
  const SvgStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
    );
  }
}

class AddFirstPantryButton extends StatelessWidget {
  const AddFirstPantryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpButton.filledButton(
      child: const Text('Start your first pantry',
          style: TextStyle(color: Colors.white)),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AddPantryDialog());
      },
    );
  }
}

// Stack(children: [
// Container(
// margin: const EdgeInsets.all(32),
// child: AspectRatio(
// aspectRatio: 1,
// child: ClipRRect(
// borderRadius: BorderRadius.circular(32),
// child: SvgPicture.asset(
// 'assets/pantry_welcome.svg',
// semanticsLabel: 'Food pantry',
// ),
// ),
// ),
// ), //Image container
// const Positioned(
// left: 0,
// right: 0,
// top: 0,
// bottom: 0,
// child: Center(
// child: Card(
// child: Padding(
// padding: EdgeInsets.all(24.0),
// child: Text('This pantry has no categories yet.'),
// ),
// ),
// ),
// )
// ]),