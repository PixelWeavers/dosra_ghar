import 'package:dosra_ghar/firebase_options.dart';
import 'package:dosra_ghar/providers/firebase_provider.dart';
import 'package:dosra_ghar/providers/issue_provider.dart';
import 'package:dosra_ghar/providers/laundry_provider.dart';
import 'package:dosra_ghar/providers/menu_provider.dart';
import 'package:dosra_ghar/providers/ngo_provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/responses/carpoolResponse.dart';
import 'package:dosra_ghar/utils/auth.dart';
import 'package:dosra_ghar/views/auth_view.dart';
import 'package:dosra_ghar/views/found_screen.dart';
import 'package:dosra_ghar/views/lost_screeen.dart';
import 'package:dosra_ghar/views/home.dart';
import 'package:dosra_ghar/views/volunteer_screen.dart';
import 'package:dosra_ghar/views/volunteerr_list_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dosra_ghar/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VolunteerProvider()),
        ChangeNotifierProvider(create: (_) => WeRideProvider()),
        ChangeNotifierProvider(create: (_) => LaundryProvider()),
        ChangeNotifierProvider(create: (_) => IssueProvider())
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DusraGhar',
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: FutureBuilder<bool>(
              future: authProvider.isUserSignedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasData && snapshot.data!) {
                    return FoundScreen();
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
