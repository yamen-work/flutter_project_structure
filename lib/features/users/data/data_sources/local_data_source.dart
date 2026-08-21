import '../user_model.dart';

class UserLocalDataSource {

  List<UserModel> _users = [];

  Future<List<UserModel>> getUsers() async {
    return _users;
  }

  Future<void> saveUsers(List<UserModel> users) async {
    _users = users;
  }
}