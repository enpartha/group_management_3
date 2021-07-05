// import 'package:cytoapp1/models/member.dart';
import 'dart:convert';

import '../models/http_exception.dart';

import '../providers/group_members.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/group.dart';

class Groups with ChangeNotifier {
  var groupId;

  static List<Group> _groupItems = [];

  final url = Uri.https(
      'cytoclick-dev-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/groups.json');
  List<Group> get items {
    return [..._groupItems];
  }

  Group findById(String id) {
    return _groupItems.firstWhere((group) => group.id == id);
  }

  Future<void> fetchGroups() async {
    try {
      final response = await http.get(url);
      final decodedJSON = jsonDecode(response.body);

      final extractedData =
          decodedJSON != null ? decodedJSON as Map<String, dynamic> : {};
      final List<Group> loadedGroups = [];
      extractedData.forEach((groupId, groupData) {
        loadedGroups.add(Group(
          id: groupId,
          groupName: groupData['name'],
          hospitalName: groupData['hospital'],
          departmentName: groupData['department'],
          adminId: groupData['adminId'],
        ));
      });

      _groupItems = loadedGroups;

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addGroup(group) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': group.groupName,
          'hospital': group.hospitalName,
          'department': group.departmentName,
        }),
      );
      final newGroup = Group(
        groupName: group.groupName,
        hospitalName: group.hospitalName,
        departmentName: group.departmentName,
        id: json.decode(response.body)['name'],
      );
      _groupItems.add(newGroup);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateGroup(id, Group group) async {
    final groupIndex = _groupItems.indexWhere((element) => element.id == id);
    if (groupIndex >= 0) {
      final _url = Uri.https(
          'cytoclick-dev-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/groups/$id.json');
      http.patch(_url,
          body: json.encode({
            'name': group.groupName,
            'hospital': group.hospitalName,
            'department': group.departmentName,
          }));
      _groupItems[groupIndex] = group;
      _groupItems[groupIndex].id = id;
      notifyListeners();
    }
  }

  void updateAdmin(id, String adminId) {
    final groupIndex = _groupItems.indexWhere((element) => element.id == id);
    if (groupIndex >= 0) {
      final _url = Uri.https(
          'cytoclick-dev-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/groups/$id.json');
      http.patch(_url,
          body: json.encode({
            'adminId': adminId,
          }));
      _groupItems[groupIndex].adminId = adminId;

      notifyListeners();
    }
  }

  Future<void> deleteGroup(id) async {
    final _url = Uri.https(
        'cytoclick-dev-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/groups/$id.json');
    final existingGroupIndex =
        _groupItems.indexWhere((element) => element.id == id);
    var existingGroup = _groupItems[existingGroupIndex];
    _groupItems.removeAt(existingGroupIndex);
    // print('deleted');
    notifyListeners();
    final response = await http.delete(_url);
    if (response.statusCode >= 400) {
      _groupItems.insert(existingGroupIndex, existingGroup);
      notifyListeners();
      throw HttpException('Could not delete.');
    }
    existingGroup = Group();
  }
}
