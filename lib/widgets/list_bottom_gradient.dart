import 'package:flutter/material.dart';

class ListBottomGradient extends StatelessWidget {
  const ListBottomGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.0),
            ],
          ),
        ),
        width: double.infinity,
        height: 50.0,
      ),
    );
  }
}


