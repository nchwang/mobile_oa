class UserApi {
  // 用户登录
  static const String user_login = '/auth/user/login';

  // 修改密码
  static const String set_password = '/auth/user/set-password';

  // 刷新token
  static const String refresh_token = '/auth/user/refresh';
}

class DailyApi {

}

class ProjectApi{
  /**
   * To get the project list with parameters : user_id in ge method
   */
  static const String project_list = '/sales/project/?per_page=999';
  static const String project_action = '/sales/project/diary/action-codes';
}