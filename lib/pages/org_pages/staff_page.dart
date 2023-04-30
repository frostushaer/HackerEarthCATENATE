import 'package:chatapp_test1/generated/l10n.dart';
import 'package:chatapp_test1/helper/helper_function.dart';
import 'package:chatapp_test1/pages/auth/login_page.dart';
import 'package:chatapp_test1/pages/org_pages/course_page.dart';
import 'package:chatapp_test1/pages/org_pages/org_profile_page.dart';
import 'package:chatapp_test1/pages/profile_page.dart';
import 'package:chatapp_test1/pages/search_page.dart';
import 'package:chatapp_test1/pages/org_pages/staff_page.dart';
import 'package:chatapp_test1/service/auth_service.dart';
import 'package:chatapp_test1/service/database_service.dart';
import 'package:chatapp_test1/widgets/group_tile.dart';
import 'package:chatapp_test1/widgets/staff_tile.dart';
import 'package:chatapp_test1/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../LanguageChangeProvider.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  Stream? staffs;
  bool _isLoading = false;
  String groupName = "";
  String orgName = "";
  String courseName = "";
  String staffName = "";

  final formKey = GlobalKey<FormState>();
  String staffEmail = "";
  String staffPassword = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en')},
    {'name': 'ଓଡିଆ', 'locale': const Locale('hi')},
  ];

  //string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    //getting the list of snapshot in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         nextScreen(context, const SearchPage());
        //       },
        //       icon: const Icon(Icons.search))
        // ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Staffs",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              // userName,
              orgName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(context, CoursePage());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.book),
              title: const Text(
                "Courses",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                // nextScreenReplace(context, StaffPage());
                // ProfilePage(
                //   userName: userName,
                //   email: email,
                // ));
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: Text(
                "Staffs",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    OrgProfilePage(
                      userName: userName,
                      email: email,
                    ));
                // ProfilePage(
                //   userName: userName,
                //   email: email,
                // ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.person),
              title: Text(
                S.of(context).profile,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(S.of(context).logout),
                        content: Text(S.of(context).reallyLogout),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          )
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: Text(
                S.of(context).logout,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(S.of(context).chooseLanguage),
                        content: Container(
                          width: double.maxFinite,
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        // print(locale[index]['locale']);
                                        context
                                            .read<LanguageChangeProvider>()
                                            .changeLocale(locale[index]
                                                    ['locale']
                                                .toString());
                                        nextScreenReplace(
                                            context, const StaffPage());
                                        showSnackBar(context, Colors.green,
                                            S.of(context).langChanged);
                                      },
                                      child: Text(locale[index]['name'])),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Theme.of(context).primaryColor,
                                );
                              },
                              itemCount: locale.length),
                        ),
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.language),
              title: Text(
                S.of(context).language,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: staffList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    //creating course
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a Staff",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        )
                      : SingleChildScrollView(
                          child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: TextInputDecoration.copyWith(
                                        labelText: S.of(context).fullName,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    onChanged: (val) {
                                      setState(() {
                                        staffName = val;
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
                                        staffEmail = val;
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
                                        staffPassword = val;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //         primary:
                                  //             Theme.of(context).primaryColor,
                                  //         elevation: 0,
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(30))),
                                  //     child: Text(
                                  //       S.of(context).SignIn,
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontSize: 16),
                                  //     ),
                                  //     onPressed: () {
                                  //       register();
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              )))
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(S.of(context).cancle),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    S.of(context).SignIn,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    register();
                  },
                ),
              ],
            );
          }));
        });
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(
              staffName, staffEmail, staffPassword)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(staffEmail);
          await HelperFunctions.saveUserNameSF(staffName);
          nextScreenReplace(context, const StaffPage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

//give the staff list implementation
  staffList() {
    return StreamBuilder(
      stream: staffs,
      builder: (context, AsyncSnapshot snapshot) {
        //make some checks
        if (snapshot.hasData) {
          if (snapshot.data['staffs'] != null) {
            if (snapshot.data['staffs'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['staffs'].length,
                itemBuilder: ((context, index) {
                  int reverseIndex = snapshot.data['staffs'].length -
                      index -
                      1; //for most recent group to be on top
                  return StaffTile(
                      staffName:
                          getName(snapshot.data['staffs'][reverseIndex]));
                  // userName: snapshot.data['fullName']);
                }),
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Your organization dont have any staffs yet, tap on the add button to add staffs.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
