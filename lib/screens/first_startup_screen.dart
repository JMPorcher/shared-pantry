import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/screens/registration_screen.dart';
import 'package:shared_pantry/widgets/buttons.dart';

import '../providers/auth_provider.dart';

class FirstStartupScreen extends StatelessWidget {
  const FirstStartupScreen({super.key});

  static const String id = 'first startup screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColor1,
      body: SafeArea(
        child: Column(children: [
          const TitleTextWithPadding(),
          const WelcomeTextWithPadding(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SpButton.filledButton(child: const Text('Register New Account'), onTap: () {Navigator.of(context).pushNamed(RegistrationScreen.id);}),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SpButton.outlineButton(child: const Text('Login Existing Account'), onTap: () {}),
          ),
          const SkipButton(),
        ]
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
    SpAuthProvider spAuth = Provider.of<SpAuthProvider>(context);
    final navigator = Navigator.of(context);
    return MaterialButton(
        onPressed: () async {
          try {
            await spAuth.signInAnonymous().then((_) async {
              navigator.pushNamedAndRemoveUntil(MainScreen.id, (route) => false);
              final String? userID = spAuth.firebaseAuth.currentUser?.uid;
              FirebaseFirestore.instance.collection('users').doc(userID).set({
                'email': '',
                'user_name' : '',
                'subscribed_pantries' : []
              });
            });
          } catch (e) {
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to log in without an account - sorry!')));
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