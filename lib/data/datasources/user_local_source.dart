import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getUserById(String id);
  Future<void> updateUserStatus(String userId, String status);
  Future<List<UserModel>> getUsersByIds(List<String> userIds);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Map<String, UserModel> users = {};
  @override
  Future<void> cacheUser(UserModel user) async {
    // TODO: implement cacheUser
    users[user.id.toString()] = user;
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    // TODO: implement getUserById
    return users[id];
  }

  @override
  Future<List<UserModel>> getUsersByIds(List<String> userIds) async {
    // TODO: implement getUsersByIds
    return userIds.map((id) => users[id]).whereType<UserModel>().toList();
  }

  @override
  Future<void> updateUserStatus(String userId, String status) async {
    // TODO: implement updateUserStatus
    final user = users[userId];
    if (user != null) {
      users[userId] = user.copyWith(status: status);
    }
  }
}
