import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/pantry_screen.dart';

import '../constants.dart';

class RegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegistrationForm({super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final currentState = formKey.currentState;
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        onChanged: () {
          if (currentState != null) currentState.validate(); // Update the validation status
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value == '') {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value == '') {
                  return 'Please enter your email';
                }
                // You can add more complex email validation here
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value == '') {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
                onPressed: () {
                    currentState?.validate() == true
                        ? Navigator.pushNamed(context, PantryScreen.id)
                        : null;
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0), color: kColor5),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ))),
          ],
        ),

      ),
    );
  }
}
//TODO: Make error messages appear
