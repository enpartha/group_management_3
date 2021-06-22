import 'package:flutter/material.dart';
import './screens/manage_groups.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ManageGroupsPage();
  }
}
