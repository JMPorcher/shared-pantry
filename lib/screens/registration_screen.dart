import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/widgets/auth_form.dart';

import '../providers/auth_provider.dart';
import '../widgets/buttons.dart';
import 'main_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  static const String id = 'registration screen';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);
  final TextEditingController usernameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final SpAuthProvider spAuth = Provider.of<SpAuthProvider>(context);

    void verifyInputAndRegister(
        BuildContext context, SpAuthProvider spAuth) async {
      final currentState = formKey.currentState;
      if (currentState != null && currentState.validate()) {
        final String userName = usernameTEController.text;
        final String eMail = emailTEController.text;
        final String password = passwordTEController.text;
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        try {
          await spAuth.firebaseAuth
              .createUserWithEmailAndPassword(email: eMail, password: password);
          final userID = spAuth.user?.uid;
          firestore.collection('users').doc(userID).set({
            'email': eMail,
            'display_name': userName,
            'subscribed_pantries': []
          }, SetOptions(merge: true));
          await spAuth.firebaseAuth
              .signInWithEmailAndPassword(email: eMail, password: password);
          if (context.mounted) {
            Navigator.pushNamed(context, MainScreen.id);
          }
        } on FirebaseAuthException catch (_) {
          scaffoldMessenger.showSnackBar(const SnackBar(
              content: Text(
                  'Email already has an account. Use a different one or reset your password.')));
          rethrow;
        }
      } else {
        isFormValidNotifier.value = false;
      }
    }

    return Center(
        child: Column(
      children: [
        AuthForm(
            isFormValidNotifier: isFormValidNotifier,
            usernameTEController: usernameTEController,
            emailTEController: emailTEController,
            passwordTEController: passwordTEController),
        Expanded(
            flex: 4,
            child: RegisterButton(
                onTap: () => verifyInputAndRegister(context, spAuth))),
      ],
    ));
  }
}

class RegisterButton extends StatelessWidget {
  final Function onTap;

  const RegisterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SpButton.filledButton(
        onTap: onTap,
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
