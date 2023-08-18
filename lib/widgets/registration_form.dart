import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/pantry_screen.dart';

import '../constants.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
            ValueListenableBuilder<bool>(
                valueListenable: isFormValidNotifier,
                builder: (context, isFormValid, child) {
                  return MaterialButton(
                      onPressed: () {
                        // Manually validate the form and update the ValueNotifier
                        final currentState = formKey.currentState;
                        if (currentState != null && currentState.validate()) {
                          Navigator.pushNamed(context, PantryScreen.id);
                        } else {
                          // Form is not valid, trigger re-build to show error messages
                          isFormValidNotifier.value = false;
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: kColor5),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )));
                }),
          ],
        ),
      ),
    );
  }
}