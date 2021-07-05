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
  var _isInit = true;
  var _isLoading = false;

  // late List<Group> myGroups = <Group>[];
  @override
  void initState() {
    // myGroups = Provider;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Groups>(context).fetchGroups().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshGroups(BuildContext context) async {
    await Provider.of<Groups>(context, listen: false).fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    final myGroups = Provider.of<Groups>(context).items;
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: () => _refreshGroups(context),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : myGroups.isEmpty
                ? Center(
                    child: Text('No Groups'),
                  )
                : Consumer<Groups>(
                    builder: (context, groups, child) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: groups.items.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Card(
                              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 8,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/group_details',
                                      arguments: groups.items[index].id);
                                },
                                child: Column(
                                  children: <ListTile>[
                                    ListTile(
                                      title:
                                          Text(groups.items[index].groupName),
                                      subtitle: Text(groups.items[index]
                                              .departmentName!.isEmpty
                                          ? ''
                                          : 'Department:' +
                                              groups.items[index]
                                                  .departmentName!),
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
                                        onSelected: (value) async {
                                          ManageGroupsPage.groupId =
                                              groups.items[index].id;
                                          // print('groupId set to: ' +
                                          //     ManageGroupsPage.groupId.toString());
                                          if (value == 'edit') {
                                            _editGroup(context,
                                                    ManageGroupsPage.groupId)
                                                .then((_) => setState(() {}));
                                          } else if (value == 'delete') {
                                            try {
                                              await Provider.of<Groups>(ctx,
                                                      listen: false)
                                                  .deleteGroup(
                                                      ManageGroupsPage.groupId);
                                            } catch (error) {
                                              scaffold.showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('Deleting Failed!'),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
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
