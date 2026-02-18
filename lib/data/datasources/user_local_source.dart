import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getUserById(String id);
  Future<void> updateUserStatus(String userId, String status);
  Future<List<UserModel>> getUsersByIds(List<String> userIds);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void> cacheUser(UserModel user) {
    // TODO: implement cacheUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsersByIds(List<String> userIds) {
    // TODO: implement getUsersByIds
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserStatus(String userId, String status) {
    // TODO: implement updateUserStatus
    throw UnimplementedError();
  }
}
