import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.email,
    required super.role,
    this.password,
  });

  final String? password;

  factory UserModel.fromSeed({
    required String id,
    required String nameAr,
    required String nameEn,
    required String email,
    required String role,
    String? password,
  }) {
    return UserModel(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      email: email,
      role: role,
      password: password,
    );
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        nameAr: nameAr,
        nameEn: nameEn,
        email: email,
        role: role,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'email': email,
        'role': role,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}
