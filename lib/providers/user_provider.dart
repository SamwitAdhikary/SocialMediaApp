import 'package:flutter/widgets.dart';
import 'package:social_media/AuthClass/auth_class.dart';
import 'package:social_media/models/usermodel.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthClass _authClass = AuthClass();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authClass.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
