import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable()
class Users {
  final int page;
  final int per_page;
  final int total;
  final int total_pages;
  final List<User> data;
  Users(
      {required this.page,
      required this.per_page,
      required this.total,
      required this.total_pages,
      required this.data});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  User(
      {required this.id,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

extension UserHelpers on Users {
  bool isAllUsersLoaded() => page >= total_pages;
}