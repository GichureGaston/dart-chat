import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    this.email,
    this.image,
    this.status = 'offline',
  });
  final String? id;
  final String? name;
  final String? email;
  final String? image;
  final String? status;
  @override
  List<Object?> get props => [id, name, email, image, status];
  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? status,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }
}
