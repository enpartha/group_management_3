import 'package:flutter/foundation.dart';

class Group with ChangeNotifier {
  String groupName;
  String? hospitalName;
  String? departmentName;
  String? id;
  // List<Member> groupMembers=[];

  Group({
    required this.groupName,
    this.hospitalName = '',
    this.departmentName = '',
    this.id,

// this.groupMembers,
  })
  // : id = id.isEmpty ? groupName : id
  ;
}
