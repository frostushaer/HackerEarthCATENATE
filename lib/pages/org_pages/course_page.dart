import 'package:chatapp_test1/generated/l10n.dart';
import 'package:chatapp_test1/helper/helper_function.dart';
import 'package:chatapp_test1/pages/auth/login_page.dart';
import 'package:chatapp_test1/pages/org_pages/org_profile_page.dart';
import 'package:chatapp_test1/pages/profile_page.dart';
import 'package:chatapp_test1/pages/search_page.dart';
import 'package:chatapp_test1/pages/org_pages/staff_page.dart';
import 'package:chatapp_test1/service/auth_service.dart';
import 'package:chatapp_test1/service/database_service.dart';
import 'package:chatapp_test1/widgets/course_tile.dart';
import 'package:chatapp_test1/widgets/group_tile.dart';
import 'package:chatapp_test1/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../LanguageChangeProvider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  Stream? courses;
  bool _isLoading = false;
  String groupName = "";
  String orgName = "";
  String courseName = "";

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
        orgName = val!;
      });
    });
    //getting the list of snapshot in our stream
    await DatabaseService(oid: FirebaseAuth.instance.currentUser!.uid)
        .getOrgCourse()
        .then((snapshot) {
      setState(() {
        courses = snapshot;
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
          "Courses",
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
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
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
                nextScreenReplace(context, StaffPage());
                // ProfilePage(
                //   userName: userName,
                //   email: email,
                // ));
              },
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
                    context, OrgProfilePage(email: email, userName: userName));
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
                                            context, const CoursePage());
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
      body: courseList(),
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
                "Create a Course",
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
                              child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  courseName = value;
                                });
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(20)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            // TextField(
                            //   onChanged: (value) {
                            //     setState(() {
                            //       courseName = value;
                            //     });
                            //   },
                            //   style: const TextStyle(color: Colors.black),
                            //   decoration: InputDecoration(
                            //       enabledBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //                   Theme.of(context).primaryColor),
                            //           borderRadius: BorderRadius.circular(20)),
                            //       errorBorder: OutlineInputBorder(
                            //           borderSide:
                            //               const BorderSide(color: Colors.red),
                            //           borderRadius: BorderRadius.circular(20)),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //                   Theme.of(context).primaryColor),
                            //           borderRadius: BorderRadius.circular(20))),
                            // ),
                          ],
                        )))
                  // : TextField(
                  //     onChanged: (value) {
                  //       setState(() {
                  //         groupName = value;
                  //       });
                  //     },
                  //     style: const TextStyle(color: Colors.black),
                  //     decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(
                  //                 color: Theme.of(context).primaryColor),
                  //             borderRadius: BorderRadius.circular(20)),
                  //         errorBorder: OutlineInputBorder(
                  //             borderSide:
                  //                 const BorderSide(color: Colors.red),
                  //             borderRadius: BorderRadius.circular(20)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(
                  //                 color: Theme.of(context).primaryColor),
                  //             borderRadius: BorderRadius.circular(20))),
                  //   ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: Text(S.of(context).cancle),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (courseName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      // create databse service for course creation
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName,
                              FirebaseAuth.instance.currentUser!.uid, groupName)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showSnackBar(
                          context, Colors.green, "Staff created successfully");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: Text(S.of(context).create),
                )
              ],
            );
          }));
        });
  }

//give the course list implementation
  courseList() {
    return StreamBuilder(
      stream: courses,
      builder: (context, AsyncSnapshot snapshot) {
        //make sime checks
        if (snapshot.hasData) {
          if (snapshot.data['courses'] != null) {
            if (snapshot.data['courses'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['courses'].length,
                itemBuilder: ((context, index) {
                  int reverseIndex = snapshot.data['courses'].length -
                      index -
                      1; //for most recent group to be on top
                  return CourseTile(
                      courseId: getId(snapshot.data['courses'][reverseIndex]),
                      courseName:
                          getName(snapshot.data['courses'][reverseIndex]),
                      adminName: snapshot.data['orgName']);
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
            "Your organization dont have any course yet, tap on the add button to create course.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
