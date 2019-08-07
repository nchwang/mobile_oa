class ResponseCode {
  static const int defined_zero = 0;
  static const int http_200 = 200;
  static const int http_400 = 400;
  static const int http_401 = 401;
  static const int http_403 = 403;
  static const int http_404 = 404;
  static const int http_500 = 500;
}

class ResponseInfo {
  // 返回数据
  static const String data = 'data';

  // 返回信息
  static const String msg = 'msg';

  // 状态码
  static const String code = 'code';

  // 主键
  static const String id = 'id';

  // 名称
  static const String name = 'name';
}
