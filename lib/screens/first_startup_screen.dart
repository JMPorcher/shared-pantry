//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/widgets/registration_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstStartupScreen extends StatelessWidget {
  const FirstStartupScreen({super.key});

  static const String id = 'first startup screen';

  @override
  Widget build(BuildContext context) {
    //FirebaseAuth auth = FirebaseAuth.instance;

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
            const RegistrationForm(),
            MaterialButton(
                onPressed: () async {
                  Navigator.pushNamed(context, MainScreen.id);
                  try {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setBool('user is not registered', true);
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

//TODO Need FirstStartupScreen to be a PageView with 3 pages: 1) ask for name - 2) skippable sign-up - 3) skippable choose pre-built pantries, categories and items
// PageView first page: Asks for a name. Registers a user with this user name and nothing else.
// PageView second page: Asks you to sign up or do so later (implement "later" after firebase sign-up functionalities are added)
// PageView third page: Asks you to add pre-build pantries, categories and items. Implement later.
