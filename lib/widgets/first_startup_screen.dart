import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/widgets/pantry_screen.dart';
import 'package:shared_pantry/widgets/registration_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstStartupScreen extends StatelessWidget {
  const FirstStartupScreen({super.key});

  static const String id = 'first startup screen';

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

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
                'Store all your household items that might deplete: from foods to cleaning supplies. '
                    'Mark any item as "run out" and check anytime what you need to buy.'
                    '\n\n'
                    'Sign up for free and share any number of Pantries with others.',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 20.0),
            const RegistrationForm(),
            MaterialButton(
                onPressed: () async {
                  Navigator.pushNamed(context, PantryScreen.id);
                  //Sign in anonymously
                  try {
                    await auth.signInAnonymously();
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    await sharedPreferences.setBool('user signed in anonymously before', true);
                  } catch (e) {
                    print(e);
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
                )),
          ]
            //TODO: Add button for sign in for returning users.
          ),
        ),
      ),
    );
  }
}
// PageView first page: Asks you to sign up or do so later (implement "later" after firebase sign-up functionalities are added)
// PageView second page: Asks you to add pre-build pantries, categories and items. Implement later.
