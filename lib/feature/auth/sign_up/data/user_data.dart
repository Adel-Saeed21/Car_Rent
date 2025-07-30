import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final String uid;
  final String email;
  final String name;
  final String phone;

  UserData({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
