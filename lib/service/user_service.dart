import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';

class UserInfoService {
  Box<UserInfo>? _userInfoBox;

  final ValueNotifier<List<UserInfo>> usersNotifier =
      ValueNotifier<List<UserInfo>>([]);

  //to create/open the box
  Future<void> openBox() async {
    _userInfoBox = await Hive.openBox<UserInfo>('USERINFOBOX');
    await _loadUsers();
  }

  //to close the box
  Future<void> closeBox() async {
    await _userInfoBox!.close();
  }

  //to add to box
  Future<void> adduser(UserInfo user) async {
    if (_userInfoBox == null) {
      await openBox();
    }
    await _userInfoBox!.add(user);
    await _loadUsers();
  }

  //to get datas from the box
  Future<List<UserInfo>> getuser() async {
    if (_userInfoBox == null) {
      await openBox();
    }
    return _userInfoBox!.values.toList();
  }

  //to update datas in the box
  Future<void> updateuser(UserInfo user, int index) async {
    if (_userInfoBox == null) {
      await openBox();
    }

    await _userInfoBox!.putAt(index, user);
    await _loadUsers();
  }

  //to delete data in the box
  Future<void> deleteuser(int index) async {
    if (_userInfoBox == null) {
      await openBox();
    }
    await _userInfoBox!.deleteAt(index);
    await _loadUsers();
  }

  // Load users from Hive and notify listeners
  Future<void> _loadUsers() async {
    usersNotifier.value = _userInfoBox!.values.toList();
    usersNotifier.notifyListeners();
  }
}
