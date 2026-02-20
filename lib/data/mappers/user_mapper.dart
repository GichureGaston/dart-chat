import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class UserMapper {
  static UserModel toModel(UserEntity entity) {
    return UserModel(id: entity.id, name: entity.name, status: entity.status);
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity(id: model.id, name: model.name, status: model.status);
  }
}
