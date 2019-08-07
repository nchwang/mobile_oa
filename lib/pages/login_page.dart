import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'home_page.dart';
import 'package:mobile_oa/constant/route_config.dart';
import 'package:dio/dio.dart';
import 'package:mobile_oa/utils/dio_utils.dart';
import 'package:mobile_oa/utils/shared_preferences_utils.dart';
import 'package:mobile_oa/constant/api_config.dart';
import 'package:mobile_oa/constant/restfulapis.dart';
import 'package:mobile_oa/model/user_login_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 账号
  String _account;

  // 密码
  String _password;

  // 模糊密码
  bool _isObscure = true;

  // 记住密码
  bool _isRemember = false;

  // 账号焦点
  FocusNode _accountFocus = FocusNode();

  // 密码焦点
  FocusNode _passwordFocus = FocusNode();

  // 账号控制器
  TextEditingController _accountController = TextEditingController();

  // 密码控制器
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                children: <Widget>[
                  _buildLogo(),
                  _buildSizedBox(300.0),
                  _buildAccount(),
                  _buildSizedBox(8.0),
                  _buildPassword(),
                  _buildSizedBox(24.0),
                  _buildLoginButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSizedBox(height) {
    return SizedBox(height: ScreenUtil.getInstance().setHeight(height));
  }

  Widget _buildAccount() {
    return TextFormField(
      focusNode: _accountFocus,
      keyboardType: TextInputType.text,
      controller: _accountController,
      autofocus: false,
      decoration: InputDecoration(
        labelText: '账号',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: '输入姓名的全拼',
        hintStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
      ),
      onSaved: (String value) => _account = value,
      validator: (String value) {
        if (value.isEmpty) {
          return '请填写账号';
        }
      },
      onEditingComplete: () {
        // 焦点移动到密码框
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      autofocus: false,
      focusNode: _passwordFocus,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: '密码',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: '输入对应密码',
        hintStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock_open, color: Colors.blueAccent),
      ),
      onSaved: (String value) => _password = value,
      validator: (String value) {
        if (value.isEmpty) {
          return '请填写密码';
        }
      },
      onFieldSubmitted: (String value) {
        _accountFocus.unfocus();
        _passwordFocus.unfocus();
      },
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            // 执行登录方法
            //Navigator.of(context).pushNamed(HomePage.tag);
            _userLogin(context);
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('登录', style: TextStyle(color: Colors.white)),

      ),
    );
  }

  Widget _buildLogo() {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/logo.png"),
            //fit: BoxFit.cover,
          ),
        ),
        height: ScreenUtil.getInstance().setHeight(120.0));
  }

  // 调用用户登录接口
  Future<void> _userLogin(BuildContext context) async {
    try {
      Dio dio = DioUtils.getInstance().tokenDio;
      Response response = await dio.post(UserApi.user_login, queryParameters: {
        'grant_type': 'password',
        'username': _account,
        'password': _password
      });

      if (response.data[ResponseInfo.code] == ResponseCode.defined_zero) {
        UserLoginData userLoginData =
        UserLoginData.fromJson(response.data[ResponseInfo.data]);
        Map<String, dynamic> dataMap = Map<String, dynamic>();
        dataMap[SharedPreferencesUtils.accessToken] = userLoginData.token;
        dataMap[SharedPreferencesUtils.refreshToken] =
            userLoginData.refreshToken;
        dataMap[SharedPreferencesUtils.id] = userLoginData.userinfo.id;
        dataMap[SharedPreferencesUtils.username] =
            userLoginData.userinfo.username;
        dataMap[SharedPreferencesUtils.nickname] =
            userLoginData.userinfo.nickname;
        dataMap[SharedPreferencesUtils.gender] = userLoginData.userinfo.gender;
        dataMap[SharedPreferencesUtils.email] = userLoginData.userinfo.email;
        dataMap[SharedPreferencesUtils.isRemember] = _isRemember;
        dataMap[SharedPreferencesUtils.account] = _account;
        dataMap[SharedPreferencesUtils.password] = _password;
        await SharedPreferencesUtils.saveUserInfo(dataMap);
//        Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
//              (Route<dynamic> route) => false,
//        );
        Navigator.of(context).pushNamed(RouteConfig.ROUTE_HOME_PAGE);
      } else {
        _showMsg(response.data[ResponseInfo.msg]);
        return;
      }
    } on Exception catch (e) {
      _showMsg('登录失败');
      throw e;
    }
  }

  void _showMsg(String msg) {
//    _scaffoldKey.currentState.showSnackBar(
//      SnackBar(
//        content: Text(msg),
//        duration: Duration(seconds: 2),
//      ),
//    );
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
