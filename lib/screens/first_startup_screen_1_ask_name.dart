import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_pantry/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/sp_button.dart';
import 'main_screen.dart';

class FirstStartupScreen1 extends StatelessWidget {
  FirstStartupScreen1({super.key});

  final FirebaseAuth firebaseInstance = FirebaseAuth.instance;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userDisplayName = '';

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                  'Hi, what should we call you?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
              const Text('(You can change that later)'),
              TextField(
                controller: textEditingController,
                onChanged: (newString) =>
                    userDisplayName = textEditingController.text,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 3)
                  ),
                ),
              ),
              SpButton(
                onTap: () async {
                  if (userDisplayName.isNotEmpty){
                    Navigator.pushNamed(context, MainScreen.id);
                    try {
                      SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                      sharedPreferences.setBool('user is not registered', true);
                      sharedPreferences.setString(
                          'User display name', userDisplayName);
                      final userCredential = await firebaseInstance.signInAnonymously();
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
                      usersCollection.doc(userCredential.user?.uid).set(
                          {'display_name': userDisplayName}, SetOptions(merge: true));
                      print(userCredential.user?.uid);
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    ScaffoldMessenger.of(context).
                      showSnackBar(
                      SnackBar(content: Text('Ur name plz bro lol'))
                    );
                  }


                },
                child: const Text('Next', style: TextStyle(color: kColor1),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
