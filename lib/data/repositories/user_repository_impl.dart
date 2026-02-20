import 'package:realtimechatapp/domain/entities/user.dart';
import 'package:realtimechatapp/domain/repositories/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity?> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<List<UserEntity>> getUsersByIds(List<String> userIds) {
    // TODO: implement getUsersByIds
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(UserEntity user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserStatus(String userId, String status) {
    // TODO: implement updateUserStatus
    throw UnimplementedError();
  }
}
