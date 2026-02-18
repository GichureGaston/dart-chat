import 'package:realtimechatapp/data/models/user_model.dart';
import 'package:realtimechatapp/domain/entities/user.dart';

extension UserEntityMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      image: image,
      status: status,
    );
  }
}

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      image: image,
      status: status,
    );
  }
}
