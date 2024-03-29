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
import 'package:shared_pantry/screens/profile_page.dart';
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
  final String lastShownPantryId =
      sharedPreferences.getString('Last shown pantry') ?? '';
  runApp(SharedPantry(lastShownScreen, lastShownPantryId));
}

class SharedPantry extends StatelessWidget {
  const SharedPantry(this.lastShownScreen, this.lastShownPantryId,
      {super.key});

  final String lastShownPantryId;
  final int lastShownScreen;

  @override
  Widget build(BuildContext context) {
    final SpAuthProvider authProvider = SpAuthProvider();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return
      //StreamProvider that returns the user's ID
      StreamProvider<User?>.value(
        initialData: null,
        value: authProvider.authStateStream,
        builder: (context, snapshot) {
          User? user = context.watch<User?>();
          print('$user is current user');
          //StreamProvider that returns the user's subscribed pantry ID's
          return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (BuildContext context) => PantryProvider(user: user)),
                  ChangeNotifierProvider(create: (BuildContext context) => AppStateProvider(lastShownScreen, lastShownPantryId)),
                ],
                child: MaterialApp(
                    title: 'Shared Pantry',
                    routes: {
                      ProfilePage.id: (context) => ProfilePage(),
                      MainScreen.id: (context) => const MainScreen(),
                      FirstStartupScreen.id: (context) => const FirstStartupScreen(),
                    },
                    home: user == null ? const FirstStartupScreen() : const MainScreen(),
                  ),
              );
            }
          );
  }
}
