// import 'package:cytoapp1/providers/my_groups.dart';
import '../../screens/manage_groups.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/group.dart';
import '../../providers/my_groups.dart';

class EditGroupPopUp extends StatefulWidget {
  final String? groupId = ManageGroupsPage.groupId;

  EditGroupPopUp({
    Key? key,
    // this.groupId,
  }) : super(key: key);

  @override
  _EditGroupPopUpState createState() => _EditGroupPopUpState();
}

class _EditGroupPopUpState extends State<EditGroupPopUp> {
  final _hospitalFocusNode = FocusNode();
  final _departmentFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  var _editedGroup = Group(
    id: EditGroupPopUp().groupId,
    groupName: '',
    hospitalName: '',
    departmentName: '',
  );
  var _initValues = {
    'name': '',
    'hospital': '',
    'department': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    print(EditGroupPopUp().groupId);

    if (_isInit) {
      var id = EditGroupPopUp().groupId;
      if (id != null)
        _editedGroup = Provider.of<Groups>(context, listen: false).findById(id);
      print(_editedGroup.id);
      _initValues = {
        'name': _editedGroup.groupName,
        'hospital': _editedGroup.hospitalName.toString(),
        'department': _editedGroup.departmentName.toString(),
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _hospitalFocusNode.dispose();
    _departmentFocusNode.dispose();

    super.dispose();
  }

  void _saveForm() {
    final id = EditGroupPopUp().groupId;
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (id != null) {
      Provider.of<Groups>(context, listen: false).updateGroup(id, _editedGroup);
    } else {
      Provider.of<Groups>(context, listen: false).addGroup(_editedGroup);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // print(EditGroupPopUp().groupId);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      elevation: 16,
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Enter Group Details",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Divider(
                      height: 2,
                      thickness: 2,
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                    ),
                    title: TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Group Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_hospitalFocusNode);
                      },
                      onSaved: (value) {
                        _editedGroup = Group(
                          groupName: value.toString(),
                          hospitalName: _editedGroup.hospitalName,
                          departmentName: _editedGroup.departmentName,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a name.';
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: Icon(
                        Icons.local_hospital,
                        color: Colors.black,
                      ),
                    ),
                    title: TextFormField(
                      initialValue: _initValues['hospital'],
                      decoration: InputDecoration(labelText: "Hospital Name"),
                      textInputAction: TextInputAction.next,
                      focusNode: _hospitalFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_departmentFocusNode);
                      },
                      onSaved: (value) {
                        _editedGroup = Group(
                          groupName: _editedGroup.groupName,
                          hospitalName: value,
                          departmentName: _editedGroup.departmentName,
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                    ),
                    title: TextFormField(
                      initialValue: _initValues['department'],
                      decoration: InputDecoration(labelText: "Department"),
                      focusNode: _departmentFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedGroup = Group(
                          groupName: _editedGroup.groupName,
                          hospitalName: _editedGroup.hospitalName,
                          departmentName: value,
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(12),
                    child: ElevatedButton(
                      child: Text(
                        "Save",
                      ),
                      onPressed: _saveForm,

                      // color: Colors.lightBlue,
                      // textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
