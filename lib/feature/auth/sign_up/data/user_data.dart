import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserData {
  @HiveField(0)
  final String? uid;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final String? phone;

  @HiveField(4)
  final List<String>? favouriteCars;

  @HiveField(5)
  final String? profileImagePath;

  UserData({
    this.uid,
    this.email,
    this.name,
    this.phone,
    this.favouriteCars,
    this.profileImagePath,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
