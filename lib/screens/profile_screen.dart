import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  //TODO add User to constructor. User has to have name, avatar and e-mail

  static const String id = 'profile';

  Future<String> getDisplayName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('User display name') ?? 'User';
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                    future: getDisplayName(),
                    builder: (context, snapshot) {
                      String userDisplayName = snapshot.data ?? 'User';
                      return Text('Hello $userDisplayName!', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600), maxLines: 2,);
                    }),
                const Text('(+49) 123 456 789',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
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
              ]),
        ))));
  }
}

//TODO Registration and Sign-in have to happen here too. Maybe show a section that is either blank when signed in and "sign in or register" section when signed out
