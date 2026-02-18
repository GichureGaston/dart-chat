import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(checked: true)
class UserModel {
  UserModel({this.id, this.name, this.email, this.image, this.status});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  final String? id;
  final String? name;
  final String? email;
  final String? image;
  final String? status;
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }
}
