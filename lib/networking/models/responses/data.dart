// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? gender;
  final String? status;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
