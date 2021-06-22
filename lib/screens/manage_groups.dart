import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/my_groups.dart';

import './popup_dialogs/edit_group_popup.dart';

class ManageGroupsPage extends StatefulWidget {
  static String? groupId;
  static const routeName = '/manage_groups';
  const ManageGroupsPage({Key? key}) : super(key: key);

  @override
  _ManageGroupsPageState createState() => _ManageGroupsPageState();
}

class _ManageGroupsPageState extends State<ManageGroupsPage> {
  @override
  Widget build(BuildContext context) {
    final myGroups = Groups().items;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Groups(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Groups"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          onPressed: () {
            ManageGroupsPage.groupId = null;
            _editGroup(context).then((_) => setState(() {}));
          },
          label: Text("Create Group"),
        ),
        body: myGroups.isEmpty
            ? Center(
                child: Text('No Groups'),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: myGroups.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 8,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/group_details',
                            arguments: myGroups[index].groupName);
                      },
                      child: Column(
                        children: <ListTile>[
                          ListTile(
                            title: Text(myGroups[index].groupName),
                            subtitle: Text('Department:' +
                                myGroups[index].departmentName!),
                            trailing: PopupMenuButton(
                              offset: Offset(0, -35),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text(
                                    'Edit',
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text(
                                    'Delete',
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                ManageGroupsPage.groupId = myGroups[index].id;
                                // print('groupId set to: ' +
                                //     ManageGroupsPage.groupId.toString());
                                if (value == 'edit') {
                                  _editGroup(context, ManageGroupsPage.groupId)
                                      .then((_) => setState(() {}));
                                } else if (value == 'delete') {
                                  setState(() {
                                    Provider.of<Groups>(ctx, listen: false)
                                        .deleteGroup(ManageGroupsPage.groupId);
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  Future<void> _editGroup(BuildContext ctx, [id]) {
    return showDialog(
      context: ctx,
      builder: (ctx) {
        return ChangeNotifierProvider<Groups>(
          create: (_) => Groups(),
          builder: (context, child) {
            // print(groupId);
            return EditGroupPopUp();
          },
        );
      },
    );
  }
}
