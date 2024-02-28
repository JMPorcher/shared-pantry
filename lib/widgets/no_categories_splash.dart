import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoCategoriesSplashScreen extends StatelessWidget {
  const NoCategoriesSplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
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
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('This pantry is empty at the moment.'),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
