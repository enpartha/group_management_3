import 'package:flutter/material.dart';

import '../models/group.dart';

class Groups with ChangeNotifier {
  static List<Group> _groupItems = [
    Group(
      id: '1',
      groupName: 'Oncology Nurses',
      departmentName: 'Oncology',
      hospitalName: 'SSKM',
    ),
    Group(
      id: '2',
      groupName: 'ENT Nurses',
      departmentName: 'ENT',
      hospitalName: 'SSKM',
    ),
  ];
  List<Group> get items {
    return [..._groupItems];
  }

  Group findById(String id) {
    return _groupItems.firstWhere((group) => group.id == id);
  }

  void addGroup(group) {
    final newGroup = Group(
      groupName: group.groupName,
      hospitalName: group.hospitalName,
      departmentName: group.departmentName,
      id: DateTime.now().toString(),
    );

    _groupItems.add(newGroup);
    notifyListeners();
  }

  void updateGroup(id, Group group) {
    final groupIndex = _groupItems.indexWhere((element) => element.id == id);
    if (groupIndex >= 0) {
      _groupItems[groupIndex] = group;
      _groupItems[groupIndex].id = id;
      notifyListeners();
    }
  }

  void deleteGroup(id) {
    _groupItems.removeWhere((element) => element.id == id);
    print('deleted');
    notifyListeners();
  }
}
