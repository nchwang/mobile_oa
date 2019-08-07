import 'package:json_annotation/json_annotation.dart';

part 'user_login_data.g.dart';

@JsonSerializable()
class UserLoginData {
  String token;

  @JsonKey(name: 'refresh_token')
  String refreshToken;

  Userinfo userinfo;

  UserLoginData({
    this.token,
    this.refreshToken,
    this.userinfo,
  });

  factory UserLoginData.fromJson(Map<String, dynamic> json) =>
      _$UserLoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginDataToJson(this);
}

@JsonSerializable()
class Userinfo {
  int id;

  String username;

  String nickname;

  int gender;

  String email;

  Userinfo({
    this.id,
    this.username,
    this.nickname,
    this.gender,
    this.email,
  });

  factory Userinfo.fromJson(Map<String, dynamic> json) =>
      _$UserinfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserinfoToJson(this);
}
