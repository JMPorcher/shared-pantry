import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/sp_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  //TODO add User to constructor. User has to have name, avatar and e-mail

  static const String id = 'profile';

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final User? user = firebaseAuth.currentUser;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
      return userSnapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print(e);
      return null;
    }

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
                FutureBuilder<Map<String, dynamic>?>(
                    future: getUserInfo(),
                    builder: (context, snapshot) {

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Can\'t access user name'));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: Text('No user name found'));
                      } else {
                        Map<String, dynamic>? userData = snapshot.data;
                        String? userName = userData?['display_name'];
                        return Text(
                          'Hello ${userName ?? 'User'}!',
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w600),
                          maxLines: 2,
                        );
                      }
                    }),
                const Text('(+49) 123 456 789',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                //"Your pantries" box: ListView of Pantries, with nested ListViews of other users
                SpButton(
                  child: const Text(
                      'Delete account',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {},
                )
              ]),
        ))));
  }
}

//TODO Registration and Sign-in have to happen here too. Maybe show a section that is either blank when signed in and "sign in or register" section when signed out
