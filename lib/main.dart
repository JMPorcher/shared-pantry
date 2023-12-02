import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_pantry/providers/pantry_provider.dart';
import 'package:shared_pantry/screens/first_startup_screen.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final int lastShownScreen =
      sharedPreferences.getInt('Last shown screen') ?? 0;
  final int lastShownPantryIndex =
      sharedPreferences.getInt('Last shown pantry') ?? 0;
  runApp(SharedPantry(lastShownScreen, lastShownPantryIndex));
}

class SharedPantry extends StatelessWidget {
  const SharedPantry(this.lastShownScreen, this.lastShownPantryIndex,
      {super.key});

  final int lastShownPantryIndex;
  final int lastShownScreen;

  @override
  Widget build(BuildContext context) {
    final appStateProvider =
        AppStateProvider(lastShownScreen, lastShownPantryIndex);
    final AuthProvider authProvider = AuthProvider();
    final pantryProvider = PantryProvider(appStateProvider, authProvider);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: appStateProvider),
          ChangeNotifierProvider.value(value: pantryProvider),
          ChangeNotifierProvider.value(value: authProvider),
        ],
        child: FutureBuilder<User?>(
          future: authProvider.getCurrentUser(),
          builder: (context, snapshot) {
            User? user;
            if (snapshot.connectionState == ConnectionState.done) {
              user = snapshot.data;
            }
            return MaterialApp(
                title: 'Shared Pantry',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: (user == null)
                    ? const FirstStartupScreen()
                    : const MainScreen(),
                routes: {
                  ProfileScreen.id: (context) => ProfileScreen(),
                  MainScreen.id: (context) => const MainScreen(),
                });
          },
        ));
  }
}
