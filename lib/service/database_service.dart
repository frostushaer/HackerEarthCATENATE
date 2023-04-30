import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? oid, uid, cid, sid;
  DatabaseService({this.oid, this.uid, this.cid, this.sid});

  //reference for our collections
  final CollectionReference orgCollection =
      FirebaseFirestore.instance.collection("org");

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection("course");

  final CollectionReference staffCollection =
      FirebaseFirestore.instance.collection("staffs");

  //saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  //getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //get user group
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //creating a course
  //saving organization data
  Future savingOrgData(String orgName, String email) async {
    return await orgCollection.doc(oid).set({
      "orgName": orgName,
      "email": email,
      "courses": [],
      "staffs": [],
      "profilePic": "",
      "oid": oid,
    });
  }

  //get organization data
  Future gettingOrgData(String email) async {
    QuerySnapshot snapshot =
        await orgCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //get organiation course
  getOrgCourse() async {
    return orgCollection.doc(oid).snapshots();
  }

  //get organiation staff
  getOrgStaff() async {
    return orgCollection.doc(oid).snapshots();
  }

  //saving the course
  Future savingCourseData(
      String courseName, String oid, String adminName) async {
    return await courseCollection.doc(cid).set({
      "courseName": courseName,
      "adminName": adminName,
      "batches": [],
      "profilePic": "",
      "cid": cid,
      "oid": oid,
    });
  }

  //getting user data
  Future gettingCourseData(String courseName) async {
    QuerySnapshot snapshot =
        await courseCollection.where("courseName", isEqualTo: courseName).get();
    return snapshot;
  }

  //get course batch
  getCourseBatch() async {
    return courseCollection.doc(cid).snapshots();
  }

  //saving the staff
  Future savingStaffData(String staffName, String sid, String email) async {
    return await staffCollection.doc(sid).set({
      "staffName": staffName,
      "email": email,
      "batches": [],
      "profilePic": "",
      "sid": sid,
      "cid": cid,
      "oid": oid,
    });
  }

  //getting staff data
  Future gettingStaffData(String staffName) async {
    QuerySnapshot snapshot =
        await courseCollection.where("staffName", isEqualTo: staffName).get();
    return snapshot;
  }

  // get staff batch
  getStaffBatch() async {
    return staffCollection.doc(sid).snapshots();
  }

  //creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //update the member
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  //getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //search
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //function --> bool, take user value and check whether that user is available in the group
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  //toggling the group join or exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    //if user has a group, then remove them or also in other part rejoin them
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  //send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
