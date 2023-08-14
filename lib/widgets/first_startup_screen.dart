import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/widgets/pantry_screen.dart';
import 'package:shared_pantry/widgets/registration_form.dart';

class FirstStartupScreen extends StatelessWidget {
  const FirstStartupScreen({super.key});

  static const String id = 'first startup screen';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    
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
                'In Shared Pantry you can store Pantries for any of your household items, from foods to cleaning sponges. '
                'You can mark any of your items as "run out" so you can check anytime what you need to buy while.'
                '\n\n'
                'Or share any number Pantries with others so everybody knows if they ran out. To use this feature sign up for free.',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 20.0),
            RegistrationForm(formKey: formKey),
            MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, PantryScreen.id);
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
