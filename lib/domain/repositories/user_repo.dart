import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> saveUser({UserEntity? user});
  Future<Either<Failure, UserEntity?>> getUserById(String? id);
  Future<Either<Failure, void>> updateUserStatus(
    String? userId,
    String? status,
  );
  Future<Either<Failure, List<UserEntity>?>> getUsersByIds(String? userIds);
}
