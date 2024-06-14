import 'package:flutter/cupertino.dart';

class ShareProfife extends ChangeNotifier {
  late String profileName;
  late String moblie;
  ShareProfife({this.profileName = 'Your Name', this.moblie = 'Mobile'});
  void changeName({
    required String newName,
    required String newMobile,
  }) async {
    profileName = newName;
    moblie = newMobile;
    notifyListeners();
  }
}

class ChangeProfile extends ChangeNotifier {
  late String editName;
  late String editMobile;
  ChangeProfile({this.editName = 'Your Name', this.editMobile = 'Mobile'});
  void changeDetails(
      {required String editedName, required String editedMobile}) async {
    editName = editedName;
    editMobile = editedMobile;
    notifyListeners();
  }
}
