import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.email,
    required this.role,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final String email;
  final String role;

  @override
  List<Object?> get props => [id, nameAr, nameEn, email, role];
}
