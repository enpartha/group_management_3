import 'package:flutter/material.dart';
import '../models/member.dart';
import '../providers/group_members.dart';

class ViewGroupDetails extends StatelessWidget {
  static const routeName = '/group_details';
  const ViewGroupDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageTitle = ModalRoute.of(context)?.settings.arguments as String;
    List<Member> groupMembers = Members.members;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(pageTitle),
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
                          subtitle: Text(
                              'Level: ' + groupMembers[index].seniorityLevel),
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
                            ],
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
