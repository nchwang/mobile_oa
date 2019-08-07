import 'package:dio/dio.dart';
import 'package:mobile_oa/api/user_api.dart';
import 'package:mobile_oa/constant/restfulapis.dart';
import 'package:mobile_oa/utils/event_bus_utils.dart';
import 'package:mobile_oa/utils/shared_preferences_utils.dart';

class DioUtils {
  // 唯一数据源
  static const String api_v1_url = 'http://221.7.41.12:81/api/v1';

  // 测试数据源
//  static const String api_v1_url = 'http://192.168.3.42:5000/api/v1';

  // Dio单例
  Dio dio;

  // 创建一个新的实例
  Dio tokenDio = new Dio(BaseOptions(
    baseUrl: api_v1_url,
    connectTimeout: 15000,
  ));

  // 静态私有成员，没有初始化
  static DioUtils _instance;

  // Dio单例模式
  static DioUtils getInstance() {
    if (_instance == null) {
      _instance = DioUtils();
    }
    return _instance;
  }

  // 获取新的accessToken
  static Future<String> getAccessToken() async {
    // 获取当前的accessToken
    String accessToken = await SharedPreferencesUtils.readAccessToken();
    // 获取当前的refreshToken
    String refreshToken = await SharedPreferencesUtils.readRefreshToken();

    if (refreshToken == null) {
      return null;
    }

    // 创建新Dio实例
    Dio dio = new Dio(BaseOptions(
      baseUrl: api_v1_url,
      connectTimeout: 15000,
    ));
    dio.options.headers['Authorization'] = 'Bearer ' + refreshToken;

    try {
      // 调用accessToken刷新的接口
      Response response = await dio.post(UserApi.refresh_token);
      if (response.data == null) {
        return null;
      }

      // 新的accessToken
      accessToken = response.data['token'];
      // 保存新的accessToken
      SharedPreferencesUtils.saveAccessToken(accessToken);
    } on DioError catch (e) {
      // refreshToken过期
      if (e.response.statusCode == ResponseCode.http_401) {
        // 弹出登录页
        Global.eventBus.fire(LoginEvent(LoginEventName.login));
      }
    }
    return accessToken;
  }

  // 获取Dio
  Future<Dio> getDio() async {
    String accessToken = await SharedPreferencesUtils.readAccessToken();
    if (accessToken == null) {
      return null;
    }
    dio = Dio(BaseOptions(
      baseUrl: api_v1_url,
      connectTimeout: 15000,
    ));
    // 添加token拦截器
    dio.interceptors.add(TokenInterceptor());
    dio.options.headers['Authorization'] = 'Bearer ' + accessToken;
    return dio;
  }
}

class TokenInterceptor extends Interceptor {
  @override
  onError(DioError err) async {
    if (err.response == null) {
      return super.onError(err);
    }

    // token过期
    if (err.response.statusCode == ResponseCode.http_401) {
      // 获取Dio单例
      Dio dio = DioUtils.getInstance().dio;
      dio.lock();
      // 异步获取新的accessToken
      String accessToken = await DioUtils.getAccessToken();
      dio.unlock();
      // 重新请求
      RequestOptions requestOptions = err.response.request;
      requestOptions.headers['Authorization'] = 'Bearer ' + accessToken;
      try {
        Response response = await dio.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          cancelToken: requestOptions.cancelToken,
          options: requestOptions,
          onReceiveProgress: requestOptions.onReceiveProgress,
        );
        return response;
      } on DioError catch (e) {
        return e;
      }
    }
  }
}
