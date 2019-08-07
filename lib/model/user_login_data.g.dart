// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginData _$UserLoginDataFromJson(Map<String, dynamic> json) {
  return UserLoginData(
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
      userinfo: json['userinfo'] == null
          ? null
          : Userinfo.fromJson(json['userinfo'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserLoginDataToJson(UserLoginData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refreshToken,
      'userinfo': instance.userinfo
    };

Userinfo _$UserinfoFromJson(Map<String, dynamic> json) {
  return Userinfo(
      id: json['id'] as int,
      username: json['username'] as String,
      nickname: json['nickname'] as String,
      gender: json['gender'] as int,
      email: json['email'] as String);
}

Map<String, dynamic> _$UserinfoToJson(Userinfo instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'email': instance.email
    };
