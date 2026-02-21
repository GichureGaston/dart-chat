import 'package:realtimechatapp/data/datasources/user_local_source.dart';
import 'package:realtimechatapp/data/mappers/user_mapper.dart';
import 'package:realtimechatapp/domain/entities/user.dart';
import 'package:realtimechatapp/domain/repositories/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  UserRepositoryImpl({required this.localDataSource});
  @override
  Future<UserEntity?> getUserById(String id) async {
    // TODO: implement getUserById
    try {
      final model = await localDataSource.getUserById(id);
      if (model == null) return null;
      return UserMapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserEntity>> getUsersByIds(List<String> userIds) async {
    try {
      final models = await localDataSource.getUserById(userIds.toString());
      return models?.map((model) => UserMapper.toEntity(model));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    // TODO: implement saveUser
    try {
      final model = UserMapper.toModel(user);
      await localDataSource.cacheUser(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserStatus(String userId, String status) async {
    // TODO: implement updateUserStatus
    try {} catch (e) {}
  }
}
