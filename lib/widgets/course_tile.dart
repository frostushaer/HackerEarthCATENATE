import 'package:chatapp_test1/pages/chat_page.dart';
import 'package:chatapp_test1/pages/org_pages/batch_page.dart';
import 'package:chatapp_test1/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CourseTile extends StatefulWidget {
  final String adminName;
  final String courseId;
  final String courseName;
  const CourseTile(
      {Key? key,
      required this.courseId,
      required this.courseName,
      required this.adminName})
      : super(key: key);

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, const BatchPage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.courseName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            widget.courseName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            S.of(context).groupTileSubTitle + "${widget.adminName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
