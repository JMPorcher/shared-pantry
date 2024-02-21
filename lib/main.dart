import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_pantry/providers/user_provider.dart';
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
    final SpAuthProvider authProvider = SpAuthProvider();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: appStateProvider ),
          ChangeNotifierProvider.value(value: authProvider),
        ],
        child: StreamBuilder<User?>(
          stream: authProvider.authStateStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              User? user = snapshot.data;
              return MaterialApp(
                  title: 'Shared Pantry',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: (user == null)
                      ? const FirstStartupScreen()
                      : UserProvider(
                          userId: user.uid,
                          child: const MainScreen()
                        ),
                  routes: {
                    ProfilePage.id: (context) => ProfilePage(),
                    MainScreen.id: (context) => const MainScreen(),
                    FirstStartupScreen.id: (context) => const FirstStartupScreen(),
                  });

            }

          },
        ));
  }
}
