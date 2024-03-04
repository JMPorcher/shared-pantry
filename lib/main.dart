import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/app_state_provider.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_pantry/screens/first_startup_screen.dart';
import 'package:shared_pantry/screens/main_screen.dart';
import 'package:shared_pantry/screens/profile_page.dart';
import 'package:shared_pantry/services/database_services.dart';
import 'package:shared_pantry/providers/pantry_list_provider.dart';
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
    //TODO Move AppStateProvider below PantryListProvider so it can check whether the last shown pantry's ID is in active user's pantries
    return
      //StreamProvider that returns the user's ID
      StreamProvider<User?>.value(
        initialData: null,
        value: authProvider.authStateStream,
        builder: (context, snapshot) {
          User? user = context.watch<User?>();
          //StreamProvider that returns the user's subscribed pantry ID's
          return StreamProvider<List<String>>.value(
            initialData: const [],
            value: DatabaseService().streamPantrySubscriptionIds(
            user?.uid),
            builder: (context, snapshot) {
              print('UserId sent to pantry ID stream: ${user?.uid}');
              List<String> pantryIds = context.watch<List<String>>();
              print('Streamed pantry Ids: ${pantryIds.toString()}');
              return PantryListProvider(
                pantryIds: pantryIds.isNotEmpty
                ? pantryIds
                : [],
                child: ChangeNotifierProvider(create: (BuildContext context) => AppStateProvider(lastShownScreen, lastShownPantryId),
                  //TODO Need to supply the active user's pantriList to the AppStateProvider
                  child: MaterialApp(
                    title: 'Shared Pantry',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    routes: {
                      ProfilePage.id: (context) => ProfilePage(),
                      MainScreen.id: (context) => const MainScreen(),
                      FirstStartupScreen.id: (context) => const FirstStartupScreen(),
                    },
                    home: user == null ? const FirstStartupScreen() : const MainScreen(),
                  ),
                ),
              );
            }
          );
          },
      );
  }
}
