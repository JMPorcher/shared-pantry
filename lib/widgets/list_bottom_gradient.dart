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
              Colors.white.withOpacity(0.5), // Start with transparent
              Colors.white.withOpacity(0.0), // Transition to white or any other color
            ],
          ),
        ),
        width: double.infinity, // Width as per your requirements
        height: 50.0, // Height as per your requirements
      ),
    );
  }
}


