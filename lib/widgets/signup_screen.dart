import 'package:flutter/material.dart';

import '../constants.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  static const String id = 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColor3,
        body: SafeArea(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        const Text('Signup Screen Hello User_1', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),),
                        const Text('Signup Screen (+49) 123 456 789)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                        //"Your pantries" box: ListView of Pantries, with nested ListViews of other users
                        MaterialButton(
                          onPressed: () {
                            // SAFETY QUESTION: Are you sure? This will ...
                            // Delete data "user" from Firebase
                            // Delete user authentication data from firebase
                            // Delete user as participant in shared pantries
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
                              'Delete account',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                )
            )
        )
    );
  }
}
