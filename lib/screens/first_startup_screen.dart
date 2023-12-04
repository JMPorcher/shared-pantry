import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/widgets/registration_form.dart';

import '../providers/auth_provider.dart';

class FirstStartupScreen extends StatelessWidget {
  const FirstStartupScreen({super.key});

  static const String id = 'first startup screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            TitleTextWithPadding(),
            WelcomeTextWithPadding(),
            SizedBox(height: 20.0),
            RegistrationForm(),
            SkipButton(),
          ]
          ),
        ),
      ),
    );
  }
}

class TitleTextWithPadding extends StatelessWidget {
  const TitleTextWithPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Welcome to Shared Pantry',
        style: kTitleTextStyle,
      ),
    );
  }
}

class WelcomeTextWithPadding extends StatelessWidget {
  const WelcomeTextWithPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'Keep track all your household items that might deplete: from foods to cleaning supplies. '
            '\n\n'
            'Sign up for free and share any number of Pantries with others.',
        style: kBodyTextStyle,
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});


  @override
  Widget build(BuildContext context) {
    AuthProvider firebaseInstance = context.watch<AuthProvider>();
    final navigator = Navigator.of(context);
    return MaterialButton(
        onPressed: () async {
          try {
            await firebaseInstance.signInAnonymous().then((_) {
              navigator.pushNamedAndRemoveUntil(MainScreen.id, (route) => false);
              final String? userID = firebaseInstance.firebaseAuth.currentUser?.uid;
              FirebaseFirestore.instance.collection('users').doc(userID).set({
                'email': '',
                'user_name' : '',
                'subscribed_pantries' : []
              })
              //Add an object with the userID into a 'users' collection
              ;
            });
          } catch (e) {
            rethrow;
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No thanks, I can sign up later at any time',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ));
  }
}