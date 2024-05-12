import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';

class UserInfoService {
  Box<UserInfo>? _userInfoBox;

  //to create/open the box
  Future<void> openBox() async {
    _userInfoBox = await Hive.openBox<UserInfo>('USERINFOBOX');
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
  }

  //to get datas from the box
  Future<List<UserInfo>> getuser() async {
    if (_userInfoBox == null) {
      await openBox();
    }
    return _userInfoBox!.values.toList();
  }

  //to update datas in the box
  Future<void> updateuser(int index, UserInfo user) async {
    if (_userInfoBox == null) {
      await openBox();
    }

    await _userInfoBox!.putAt(index, user);
  }

  //to delete data in the box
  Future<void>deleteuser(int index) async{
     if (_userInfoBox == null) {
      await openBox();
    }
    await _userInfoBox!.deleteAt(index);
  }
}
