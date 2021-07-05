import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/member.dart';
import '../providers/group_members.dart';
import '../providers/my_groups.dart';

class ViewGroupDetails extends StatelessWidget {
  static const routeName = '/group_details';
  const ViewGroupDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)?.settings.arguments as String;
    final group = Provider.of<Groups>(context).findById(groupId);
    final allMembers = Provider.of<Members>(context).items;
    List<Member> groupMembers =
        allMembers.where((member) => member.groupId == groupId).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(group.groupName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: groupMembers.isEmpty
          ? Center(
              child: Text('No Members'),
            )
          : ListView.builder(
              itemCount: groupMembers.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 8,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <ListTile>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                          title: Text(groupMembers[index].name),
                          subtitle: Text(groupMembers[index].id == group.adminId
                              ? 'Level: ' +
                                  groupMembers[index].seniorityLevel +
                                  '    -> Admin'
                              : 'Level: ' + groupMembers[index].seniorityLevel),
                          trailing: PopupMenuButton(
//                             onSelected: (value) {
//                             if (value == 'remove'){
// _remove
//                             }
                            // },
                            offset: Offset(0, -35),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove'),
                              ),
                              PopupMenuItem(
                                value: 'SetAdmin',
                                child: Text('Set as Admin'),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'SetAdmin') {
                                Provider.of<Groups>(ctx, listen: false)
                                    .updateAdmin(
                                        groupId, groupMembers[index].id);
                              } else if (value == 'remove') {
                                Provider.of<Members>(ctx, listen: false)
                                    .removeMember(groupMembers[index].id);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
