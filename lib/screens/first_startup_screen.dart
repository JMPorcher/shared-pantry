import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/widgets/registration_form.dart';

class FirstStartupScreen extends StatelessWidget {
  const FirstStartupScreen({super.key});

  static const String id = 'first startup screen';

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseInstance = FirebaseAuth.instance;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Welcome to Shared Pantry',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Keep track all your household items that might deplete: from foods to cleaning supplies. '
                    '\n\n'
                    'Sign up for free and share any number of Pantries with others.',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    height: 1.5
                    ),
              ),
            ),
            const SizedBox(height: 20.0),
            RegistrationForm(),
            MaterialButton(
                onPressed: () async {
                  try {
                    firebaseInstance.signInAnonymously();
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pushNamed(context, MainScreen.id);
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
                )),
          ]
            //TODO: Add button for sign in for returning users.
          ),
        ),
      ),
    );
  }
}
