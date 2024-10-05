import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_pantry/widgets/auth_form.dart';

import '../providers/auth_provider.dart';


class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  static const String id = 'registration screen';

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> isFormValidNotifier = ValueNotifier<bool>(false);
    final TextEditingController usernameTEController = TextEditingController();
    final TextEditingController emailTEController = TextEditingController();
    final TextEditingController passwordTEController = TextEditingController();
    final SpAuthProvider spAuth = SpAuthProvider();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Center(
      child: Column(
        children: [
          const AuthForm(),
          Expanded(
              flex: 4,
              child: RegisterButton(
                formKey: formKey,
                firestore: firestore,
                usernameTextEditingController: usernameTEController,
                emailTextEditingController: emailTEController,
                passwordTextEditingController: passwordTEController,
                isFormValidNotifier: isFormValidNotifier,
                spAuth: spAuth,
              )),
        ],
      )
    );
  }
}
