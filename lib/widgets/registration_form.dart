import 'package:cloud_firestore/cloud_firestore.dart';
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

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                              usernameTEController: usernameTEController,
                              emailTEController: emailTEController,
                              passwordTEController: passwordTEController,
                              isFormValidNotifier: isFormValidNotifier)),
                      const Expanded(flex: 1, child: Text('OR', textAlign: TextAlign.center,)),
                      const Expanded(flex: 4, child: LoginButton())
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
    required this.usernameTEController,
    required this.emailTEController,
    required this.passwordTEController,
    required this.isFormValidNotifier,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameTEController;
  final TextEditingController emailTEController;
  final TextEditingController passwordTEController;
  final ValueNotifier<bool> isFormValidNotifier;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    return SpButton.filledButton(
        onTap: () async {
          final currentState = formKey.currentState;
          if (currentState != null && currentState.validate()) {
            final String userName = usernameTEController.text;
            final String eMail = emailTEController.text;
            final String password = passwordTEController.text;

            final navigator = Navigator.of(context);
            await authProvider.firebaseAuth.createUserWithEmailAndPassword(
                email: eMail, password: password);
            await authProvider.firebaseAuth.signInWithEmailAndPassword(
                email: eMail, password: password).then((_) => navigator.pushNamed(MainScreen.id));

            final uid = authProvider.user?.uid;
            CollectionReference usersCollection =
                FirebaseFirestore.instance.collection('users');
            usersCollection.doc(uid).set(
                {'display_name': userName},
                SetOptions(merge: true));
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
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpButton.outlineButton(onTap: (){}, horizontalPadding: 0, child: const Text(
      'Login',
      style: kOutlineButtonTextStyle,
    ),);
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
