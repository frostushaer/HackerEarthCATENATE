import 'package:chatapp_test1/pages/chat_page.dart';
import 'package:chatapp_test1/pages/org_pages/batch_page.dart';
import 'package:chatapp_test1/pages/org_pages/staff_page.dart';
import 'package:chatapp_test1/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class StaffTile extends StatefulWidget {
  final String staffName;
  // final String courseName;
  const StaffTile({
    Key? key,
    // required this.courseId,
    required this.staffName,
  }) : super(key: key);

  @override
  State<StaffTile> createState() => _StaffTileState();
}

class _StaffTileState extends State<StaffTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, const StaffPage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.staffName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            widget.staffName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // subtitle: Text(
          //   S.of(context).groupTileSubTitle + "${widget.adminName}",
          //   style: const TextStyle(fontSize: 13),
          // ),
        ),
      ),
    );
  }
}
