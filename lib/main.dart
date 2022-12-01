import 'package:chatapp_test1/LanguageChangeProvider.dart';
import 'package:chatapp_test1/helper/helper_function.dart';
import 'package:chatapp_test1/pages/auth/login_page.dart';
import 'package:chatapp_test1/pages/org_pages/course_page.dart';
import 'package:chatapp_test1/pages/home_page.dart';
import 'package:chatapp_test1/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//Firebase initialization
  if (kIsWeb) {
    //run the inititalization for web
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    //run the initialization for android and ios
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  bool _isOrg = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
    getUserType();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          //keep user if logged in
          _isSignedIn = value;
        });
      }
    });
  }

  getUserType() async {
    await HelperFunctions.getUserTypeStatus().then((value) {
      if (value != null) {
        setState(() {
          //keep user if logged in
          _isOrg = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          locale: Provider.of<LanguageChangeProvider>(context, listen: true)
              .currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
              primaryColor: Constants().primaryColor,
              scaffoldBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          //redirect to home page
          home: _isSignedIn
              ? (_isOrg ? const CoursePage() : const HomePage())
              : const LoginPage(),
        ),
      ),
    );
  }
}
