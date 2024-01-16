import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/widgets/buttons.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);
    final TextEditingController usernameTEController = TextEditingController();
    final TextEditingController emailTEController = TextEditingController();
    final TextEditingController passwordTEController = TextEditingController();
    final SpAuthProvider spAuth = SpAuthProvider();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            NameTextFormField(usernameTEController: usernameTEController),
            const SizedBox(height: 16.0),
            EmailTextFormField(emailTEController: emailTEController),
            const SizedBox(height: 16.0),
            PasswordTextFormField(passwordTEController: passwordTEController),
            const SizedBox(height: 20.0),
            ValueListenableBuilder<bool>(
                valueListenable: isFormValidNotifier,
                builder: (context, isFormValid, child) {
                  return Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: RegisterButton(
                              formKey: formKey,
                              firestore: firestore,
                              usernameTEController: usernameTEController,
                              emailTEController: emailTEController,
                              passwordTEController: passwordTEController,
                              isFormValidNotifier: isFormValidNotifier)),
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'OR',
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          flex: 4,
                          child: LoginButton(spAuth,
                              formKey: formKey,
                              firestore: firestore,
                              usernameTEController: usernameTEController,
                              emailTEController: emailTEController,
                              passwordTEController: passwordTEController,
                              isFormValidNotifier: isFormValidNotifier))
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.formKey,
    required this.firestore,
    required this.usernameTEController,
    required this.emailTEController,
    required this.passwordTEController,
    required this.isFormValidNotifier,
  });

  final GlobalKey<FormState> formKey;
  final FirebaseFirestore firestore;
  final TextEditingController usernameTEController;
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;
  final ValueNotifier<bool> isFormValidNotifier;

  @override
  Widget build(BuildContext context) {
    final SpAuthProvider authProvider = context.watch<SpAuthProvider>();
    return SpButton.filledButton(
        onTap: () async {
          final currentState = formKey.currentState;
          if (currentState != null && currentState.validate()) {
            final String userName = usernameTEController.text;
            final String eMail = emailTEController.text;
            final String password = passwordTEController.text;

            final navigator = Navigator.of(context);
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            try {
              await authProvider.firebaseAuth.createUserWithEmailAndPassword(
                  email: eMail, password: password);
              final userID = authProvider.user?.uid;
              firestore.collection('users').doc(userID).set({
                'email': eMail,
                'display_name' : userName,
                'subscribed_pantries' : []
              }, SetOptions(merge: true));
              await authProvider.firebaseAuth
                  .signInWithEmailAndPassword(email: eMail, password: password)
                  .then((_) => navigator.pushNamed(MainScreen.id));
            } on FirebaseAuthException catch (_) {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  content: Text(
                      'Email already has an account. Use a different one or reset your password.')));
              rethrow;
            }
          } else {
            isFormValidNotifier.value = false;
          }
        },
        horizontalPadding: 0,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: FittedBox(
            child: Text(
              'Register',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(this.spAuth,
      {required this.formKey,
      required this.firestore,
      required this.usernameTEController,
      required this.emailTEController,
      required this.passwordTEController,
      required this.isFormValidNotifier,
      super.key});

  final SpAuthProvider spAuth;
  final GlobalKey<FormState> formKey;
  final FirebaseFirestore firestore;
  final TextEditingController usernameTEController;
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;
  final ValueNotifier<bool> isFormValidNotifier;

  @override
  Widget build(BuildContext context) {
    final String email = emailTEController.text;
    final String password = passwordTEController.text;
    return SpButton.outlineButton(
      onTap: () async {
        try {
          await spAuth.firebaseAuth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((_) => Navigator.pushNamed(context, MainScreen.id));
        } on FirebaseAuthException catch (e) {
          print(e);
        }
      },
      horizontalPadding: 0,
      child: const Text('Login', style: kOutlineButtonTextStyle),
    );
  }
}

//Form Fields

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordTEController,
  });

  final TextEditingController passwordTEController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailTEController,
  });

  final TextEditingController emailTEController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(labelText: 'E-mail'),
      keyboardType: TextInputType.emailAddress,
      controller: emailTEController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }
}

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    super.key,
    required this.usernameTEController,
  });

  final TextEditingController usernameTEController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(labelText: 'Username'),
      controller: usernameTEController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }
}
