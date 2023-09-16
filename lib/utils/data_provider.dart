import 'package:flutter/foundation.dart';

import '../models/user.dart';

class DataProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void saveUserData(User user) {
    _user = user;
    notifyListeners();
  }
}
