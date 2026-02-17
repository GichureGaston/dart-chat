import '../entities/user.dart';

abstract class UserRepository {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUserById(String id);
  Future<void> updateUserStatus(String userId, String status);
  Future<List<UserEntity>> getUsersByIds(List<String> userIds);
}
