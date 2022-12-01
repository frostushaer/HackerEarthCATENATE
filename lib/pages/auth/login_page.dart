import 'package:chatapp_test1/LanguageChangeProvider.dart';
import 'package:chatapp_test1/helper/helper_function.dart';
import 'package:chatapp_test1/pages/auth/org_login_page.dart';
import 'package:chatapp_test1/pages/auth/register_page.dart';
import 'package:chatapp_test1/pages/home_page.dart';
import 'package:chatapp_test1/service/auth_service.dart';
import 'package:chatapp_test1/service/database_service.dart';
import 'package:chatapp_test1/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en')},
    {'name': 'ଓଡିଆ', 'locale': const Locale('hi')},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "CATENATE",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(S.of(context).loginSlogan,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                        Image.asset("assets/login.png"),
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: S.of(context).Email,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },

                          // check tha validation
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : S.of(context).EmailValidation;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          decoration: TextInputDecoration.copyWith(
                              labelText: S.of(context).Password,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              )),
                          validator: (val) {
                            if (val!.length < 6) {
                              return S.of(context).PasswordValidation;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(
                              S.of(context).SignIn,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text.rich(TextSpan(
                          text: "Login as Organization?  ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Organization login",
                                style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const OrgLoginPage());
                                  }),
                          ],
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                          text: S.of(context).DontHaveAccount,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: S.of(context).RegisterHere,
                                style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const RegisterPage());
                                  }),
                          ],
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        Text.rich(TextSpan(
                          // text: S.of(context).DontHaveAccount,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.translate,
                                size: 18,
                              ),
                            ),
                            const TextSpan(
                              text: "  ",
                            ),
                            TextSpan(
                                text: S.of(context).language,
                                style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                S.of(context).chooseLanguage),
                                            content: Container(
                                              width: double.maxFinite,
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            // print(locale[index]['locale']);
                                                            context
                                                                .read<
                                                                    LanguageChangeProvider>()
                                                                .changeLocale(locale[
                                                                            index]
                                                                        [
                                                                        'locale']
                                                                    .toString());
                                                            nextScreenReplace(
                                                                context,
                                                                const LoginPage());
                                                            showSnackBar(
                                                                context,
                                                                Colors.green,
                                                                S
                                                                    .of(context)
                                                                    .langChanged);
                                                          },
                                                          child: Text(
                                                              locale[index]
                                                                  ['name'])),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Divider(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    );
                                                  },
                                                  itemCount: locale.length),
                                            ),
                                          );
                                        });
                                  }),
                          ],
                        )),
                      ],
                    )),
              ),
            ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
