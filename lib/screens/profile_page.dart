import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_pantry/screens/first_startup_screen.dart';

import '../constants.dart';
import '../widgets/buttons.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //TODO add User to constructor. User has to have name, avatar and e-mail

  static const String id = 'profile';

  final FirebaseAuth firebaseAuth = SpAuthProvider().firebaseAuth;

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final User? user = firebaseAuth.currentUser;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();
      return userSnapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      rethrow;
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
                DeleteAccountButton(firebaseAuth)
              ]),
        ))));
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
                          child: TitleText('Can\'t access user name'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: TitleText('No user name found'));
                    } else {
                      Map<String, dynamic>? userData = snapshot.data;
                      String? userName = userData?['display_name'];
                      return TitleText(
                        'Hello ${userName ?? 'User'}!',
                        maxLines: 2,
                      );
                    }
                  });
  }

  FutureBuilder<Map<String, dynamic>?> buildUIDText() {
    return FutureBuilder(
                  future: getUserInfo(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    String userIdString = '';
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      userIdString = 'Can\'t access user ID';
                      return UidText(
                        userIdString,
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      userIdString = 'No UID found';
                      return UidText(
                        userIdString,
                      );
                    } else {
                      userIdString =
                          firebaseAuth.currentUser?.uid ?? 'No UID found';
                      return UidText(
                        userIdString,
                      );
                    }
                  });
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.text, {
    super.key, this.maxLines = 1
  });

  final int maxLines;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: kTitleTextStyle, maxLines: maxLines,);
  }
}

class UidText extends StatelessWidget {
  const UidText(this.text, {
    super.key, this.maxLines = 1
  });

  final int maxLines;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: kBodyTextStyle, maxLines: maxLines,);
  }
}


class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton(this.auth, {
    super.key,
  });

  final FirebaseAuth auth;
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return SpButton.filledButton(
      onTap: () {
        auth.signOut();
        //Following line should be implied by the entire app listening to authstate
        //navigator.pushNamedAndRemoveUntil(FirstStartupScreen.id, (route) => false);
      },
      child: const Text('Delete account',
          style: kFilledButtonTextStyle),
    );
  }
}

//TODO Registration and Sign-in have to happen here too. Maybe show a section that is either blank when signed in and "sign in or register" section when signed out
//TODO Send user to Welcome Screen when they delete their account or log out