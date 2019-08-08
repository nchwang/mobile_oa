import 'package:mobile_oa/model/user_login_data.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  // 用户token
  static const String accessToken = 'token';
  static const String refreshToken = 'refresh_token';

  // 用户信息
  static const String id = 'id';
  static const String username = 'username';
  static const String nickname = 'nickname';
  static const String gender = 'gender';
  static const String email = 'email';

  // 是否处于登录状态
  static const String isLogin = 'isLogin';

  // 是否记住密码
  static const String isRemember = 'isRemember';

  // 账号
  static const String account = 'account';

  // 密码
  static const String password = 'password';

  // 密钥
  static const String secretKey = 'secretkey';

  // 保存用户登录信息
  static saveUserInfo(Map<String, dynamic> map) async {
    if (map == null) {
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(accessToken, map[accessToken]);
    await sp.setString(refreshToken, map[refreshToken]);
    await sp.setBool(isLogin, true);
    await sp.setBool(isRemember, map[isRemember]);
    await sp.setInt(id, map[id]);
    await sp.setString(username, map[username]);
    await sp.setString(nickname, map[nickname]);
    await sp.setInt(gender, map[gender]);
    await sp.setString(email, map[email]);

    // 记住密码为空或者为false，不执行下面的加密步骤
    if (map[isRemember] == null || !map[isRemember]) {
      return;
    }

    // 根据密码生成密钥，再用密钥生成密文
    await sp.setString(account, map[account]);
    StringCryptor cryptor = PlatformStringCryptor();
    String salt = await cryptor.generateSalt();
    String key = await cryptor.generateKeyFromPassword(map[password], salt);
    String encrypted = await cryptor.encrypt(map[password], key);
    await sp.setString(password, encrypted);
    await sp.setString(secretKey, key);
  }

  // 清空用户登录信息
  static clearUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(accessToken, '');
    await sp.setString(refreshToken, '');
    await sp.setBool(isLogin, false);
    await sp.setInt(id, -1);
    await sp.setString(username, '');
    await sp.setString(nickname, '');
    await sp.setInt(gender, -1);
    await sp.setString(email, '');
    await sp.setBool(isLogin, false);
  }

  // 读取用户登录信息
  static Future<Userinfo> readUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool loginFlag = sp.get(isLogin);
    if (loginFlag == null || !loginFlag) {
      return null;
    }
    Userinfo userinfo = Userinfo();
    userinfo.id = sp.getInt(id);
    userinfo.username = sp.getString(username);
    userinfo.nickname = sp.getString(nickname);
    userinfo.gender = sp.getInt(gender);
    userinfo.email = sp.getString(email);
    return userinfo;
  }

  // 读取账号密码
  static Future<Map<String, dynamic>> readIsRemember() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String, dynamic> map = Map<String, dynamic>();
    bool rememberFlag = sp.getBool(isRemember);
    //  记住密码为空或者为false，不执行下面的解密步骤
    if (rememberFlag == null) {
      rememberFlag = false;
    }
    map[isRemember] = rememberFlag;
    if (!rememberFlag) {
      return map;
    }

    map[account] = sp.getString(account);
    // 根据密钥获取密文
    String pwd = sp.getString(password);
    String key = sp.getString(secretKey);
    StringCryptor cryptor = PlatformStringCryptor();
    String decrypted = await cryptor.decrypt(pwd, key);
    map[password] = decrypted;
    return map;
  }

  static Future<String> getString(para) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    try{
      return sp.getString(para);
    }catch(e){
      return sp.getInt(para).toString();
    }

  }
  // 读取登录状态
  static Future<bool> readIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool loginFlag = sp.getBool(isLogin);
    if (loginFlag == null) {
      return false;
    }
    return loginFlag;
  }


  // 读取用户令牌
  static Future<String> readAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool loginFlag = sp.get(isLogin);
    if (loginFlag == null || !loginFlag) {
      return null;
    }
    return sp.getString(accessToken);
  }

  // 读取用户刷新令牌
  static Future<String> readRefreshToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool loginFlag = sp.get(isLogin);
    if (loginFlag == null || !loginFlag) {
      return null;
    }
    return sp.getString(refreshToken);
  }

  // 保存用户令牌
  static saveAccessToken(String args) async {
    if (args == null) {
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(accessToken, args);
  }
}
