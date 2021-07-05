import 'package:flutter/material.dart';

import '../models/member.dart';

class Members with ChangeNotifier {
  final List<Member> _members = [
    Member(
      id: '1',
      groupId: '1',
      name: 'Amit Sen',
      seniorityLevel: 'Senior',
    ),
    Member(
      id: '2',
      groupId: '1',
      name: 'Rabindranath Roy',
      seniorityLevel: 'Junior',
    ),
    Member(
      id: '3',
      groupId: '2',
      name: 'Sylvia Sharma',
      seniorityLevel: 'Trainee',
    ),
    Member(
      id: '4',
      groupId: '2',
      name: 'Ritu Das',
      seniorityLevel: 'Junior',
    ),
    Member(
      id: '5',
      groupId: '2',
      name: 'Mehul Roy',
      seniorityLevel: 'Junior',
    ),
    Member(
      id: '6',
      groupId: '2',
      name: 'Sampa Chakraborty',
      seniorityLevel: 'Senior',
    ),
    Member(
      id: '7',
      groupId: '2',
      name: 'Sampa Roy',
      seniorityLevel: 'Senior',
    ),
    Member(
      id: '8',
      groupId: '1',
      name: 'Oishi Das',
      seniorityLevel: 'Senior',
    ),
    Member(
      id: '9',
      groupId: '2',
      name: 'Rimpa Paul',
      seniorityLevel: 'Junior',
    ),
    Member(
      id: '10',
      groupId: '2',
      name: 'Rima Majhi',
      seniorityLevel: 'Senior',
    ),
  ];

  List<Member> get items {
    return [..._members];
  }

  void addMember(value) {
    items.add(value);
    notifyListeners();
  }

  void removeMember(id) {
    _members.removeWhere((element) => element.id == id);
    print('removed');
    notifyListeners();
  }
}
