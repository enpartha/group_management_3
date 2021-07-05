import 'package:flutter/material.dart';
import 'package:group_management_3/providers/group_members.dart';
import 'package:group_management_3/providers/my_groups.dart';
import 'package:provider/provider.dart';
import './screens/manage_groups.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Groups(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Members(),
        ),
      ],
      child: MaterialApp(
        home: ManageGroupsPage(),
      ),
    );
  }
}
