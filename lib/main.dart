// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/pantry_list_provider.dart';
import 'package:shared_pantry/widgets/pantry_screen.dart';
import 'package:shared_pantry/widgets/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(ChangeNotifierProvider(
      create: (_) => PantryProvider(), child: const SharedPantry()));
}

class SharedPantry extends StatelessWidget {
  const SharedPantry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shared Pantry',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PantryScreen(),
        routes: {
          ProfileScreen.id: (context) => const ProfileScreen(),
        });
  }
}
