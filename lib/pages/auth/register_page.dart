import 'package:chatapp_test1/helper/helper_function.dart';
import 'package:chatapp_test1/pages/auth/login_page.dart';
import 'package:chatapp_test1/pages/home_page.dart';
import 'package:chatapp_test1/service/auth_service.dart';
import 'package:chatapp_test1/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String orgName = "";
  AuthService authService = AuthService();
  String selectedOrg = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor))
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
                        Text(S.of(context).registerSlogan,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                        Image.asset("assets/register.png"),
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: S.of(context).fullName,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              fullName = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return S.of(context).nameValidation;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                        //dropdownmenu
                        const SizedBox(height: 15),

                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('org')
                                .snapshots(),
                            builder: (context, snapshot) {
                              List<DropdownMenuItem> orgItems = [];
                              if (!snapshot.hasData) {
                                const CircularProgressIndicator();
                              } else {
                                final organization =
                                    snapshot.data?.docs.reversed.toList();
                                orgItems.add(
                                  const DropdownMenuItem(
                                    value: "0",
                                    child: Text('Select University/School'),
                                  ),
                                );
                                for (var org in organization!) {
                                  orgItems.add(DropdownMenuItem(
                                      value: org.id,
                                      child: Text(
                                        org['orgName'],
                                      )));
                                }
                              }
                              return DropdownButton(
                                items: orgItems,
                                onChanged: (orgValue) {
                                  setState(() {
                                    selectedOrg = orgValue;
                                  });
                                  print(orgValue);
                                },
                                value: selectedOrg,
                                isExpanded: false,
                              );
                            }), //drop
                        const SizedBox(
                          height: 30,
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
                              S.of(context).register,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                          text: S.of(context).haveAccount,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: S.of(context).loginNow,
                                style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginPage());
                                  }),
                          ],
                        )),
                      ],
                    )),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(
              context, const Color.fromARGB(255, 101, 167, 230), value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
