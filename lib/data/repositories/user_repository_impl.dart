import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/core/errors/failures.dart';
import 'package:realtimechatapp/data/datasources/user_local_source.dart';
import 'package:realtimechatapp/data/mappers/user_mapper.dart';
import 'package:realtimechatapp/domain/entities/user.dart';
import 'package:realtimechatapp/domain/repositories/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveUser({UserEntity? user}) async {
    try {
      if (user == null) return const Right(null);
      final model = UserMapper.toModel(user);
      await localDataSource.cacheUser(model);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserById(String? id) async {
    try {
      if (id == null) return const Right(null);
      final model = await localDataSource.getUserById(id);
      if (model == null) return const Right(null);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserStatus(
    String? userId,
    String? status,
  ) async {
    try {
      if (userId == null || status == null) return const Right(null);
      await localDataSource.updateUserStatus(userId, status);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>?>> getUsersByIds(
    String? userIds,
  ) async {
    try {
      if (userIds == null) return const Right(null);
      final ids = userIds.split(',');
      final models = await localDataSource.getUsersByIds(ids);
      final entities = models.map(UserMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
