import 'package:dosra_ghar/firebase_options.dart';
import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/providers/menu_provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/utils/auth.dart';
import 'package:dosra_ghar/views/auth_view.dart';
import 'package:dosra_ghar/views/home.dart';
import 'package:dosra_ghar/views/issues.dart';
import 'package:dosra_ghar/views/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dosra_ghar/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => MMenuProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreServiceProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DusraGhar',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            // routeInformationParser: router.routeInformationParser,
            // routeInformationProvider: router.routeInformationProvider,
            // routerDelegate: router.routerDelegate,

            home: FutureBuilder<bool>(
              future: authProvider.isUserSignedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasData && snapshot.data!) {
                    return HomePage();
                  } else {
                    return const AuthView();
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
