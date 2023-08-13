import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../dialogs/add_pantry_dialog.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
            ), //Image container
            Positioned.fill(
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddPantryDialog(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: kColor5,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ), //Add Pantry button
          ],
        ),
      ),
    );
  }
}