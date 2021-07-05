import '../models/member.dart';
import 'package:flutter/foundation.dart';

class Group with ChangeNotifier {
  String groupName;
  String? hospitalName;
  String? departmentName;
  String? id;
  String? memberCount;
  List<String> memberList;
  String? adminId;
  // List<Member> groupMembers=[];

  Group({
    this.groupName = '',
    this.hospitalName = '',
    this.departmentName = '',
    this.id,
    this.memberCount,
    this.memberList = const [],
    this.adminId,

// this.groupMembers,
  })
  // : id = id.isEmpty ? groupName : id
  ;
}
