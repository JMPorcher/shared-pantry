import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/widgets/sp_button.dart';

class RegistrationForm extends StatelessWidget {
  RegistrationForm({super.key});

  final FirebaseAuth firebaseInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);
    final TextEditingController usernameTEController = TextEditingController();
    final TextEditingController emailTEController = TextEditingController();
    final TextEditingController passwordTEController = TextEditingController();

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
              controller: usernameTEController,
              validator: (value) {
                if (value == null || value.isEmpty) {
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
              controller: emailTEController,
              validator: (value) {
                if (value == null || value.isEmpty) {
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
              controller: passwordTEController,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Please enter a password with at least 6 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            ValueListenableBuilder<bool>(
                valueListenable: isFormValidNotifier,
                builder: (context, isFormValid, child) {
                  return Row(
                    children: [
                      SpButton(
                          onTap: () async {
                            final currentState = formKey.currentState;
                            if (currentState != null && currentState.validate()) {
                              final String userName = usernameTEController.text;
                              final String eMail = emailTEController.text;
                              final String password = passwordTEController.text;


                              await firebaseInstance.createUserWithEmailAndPassword(
                                  email: eMail, password: password);
                              await firebaseInstance.signInWithEmailAndPassword(
                                  email: eMail, password: password);

                              final uid = firebaseInstance.currentUser?.uid;
                              CollectionReference usersCollection =
                                  FirebaseFirestore.instance.collection('users');
                              usersCollection.doc(uid).set(
                                  {'display_name': userName},
                                  SetOptions(merge: true));

                              Navigator.pushNamed(context, MainScreen.id);
                            } else {
                              isFormValidNotifier.value = false;
                            }
                          },
                          horizontalPadding: 0,
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                      const Text('OR'),
                      SpButton(onTap: (){}, color: kColor6, horizontalPadding: 0, child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),)
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
