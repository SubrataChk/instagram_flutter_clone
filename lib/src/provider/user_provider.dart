import 'package:flutter/cupertino.dart';
import 'package:instagram_flutter_clone/src/model/user.dart';
import 'package:instagram_flutter_clone/src/service/auth_method.dart';

class UserProvider extends ChangeNotifier {
  final AuthMethod _authMethod = AuthMethod();
  UserModel? getUser;

  // UserModel get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethod.getUserDetails();
    getUser = user;

    notifyListeners();
  }
}
