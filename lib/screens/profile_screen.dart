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
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();
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
                buildGreetingTextWithName(),
                buildUIDText(),
                const DeleteAccountButton()
              ]),
        ))));
  }

  FutureBuilder<Map<String, dynamic>?> buildUIDText() {
    return FutureBuilder(
                  future: getUserInfo(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    TextStyle uidStringStyle = const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300);
                    String userIdString = '';
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      userIdString = 'Can\'t access user ID';
                      return Text(
                        userIdString,
                        style: uidStringStyle,
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      userIdString = 'No UID found';
                      return Text(
                        userIdString,
                        style: uidStringStyle,
                      );
                    } else {
                      userIdString =
                          firebaseAuth.currentUser?.uid ?? 'No UID found';
                      return Text(
                        userIdString,
                        style: uidStringStyle,
                      );
                    }
                  });
  }

  FutureBuilder<Map<String, dynamic>?> buildGreetingTextWithName() {
    return FutureBuilder<Map<String, dynamic>?>(
                  future: getUserInfo(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Can\'t access user name'));
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
                  });
  }
}

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpButton(
      onTap: () {},
      child: const Text('Delete account',
          style: TextStyle(color: Colors.white)),
    );
  }
}

//TODO Registration and Sign-in have to happen here too. Maybe show a section that is either blank when signed in and "sign in or register" section when signed out
//TODO Send user to Welcome Screen when they delete their account or log out