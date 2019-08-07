import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/home_page.dart';
import './pages/daily_page.dart';
import 'package:mobile_oa/constant/route_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    RouteConfig.ROUTE_LOGIN_PAGE : (context) => LoginPage(),
    RouteConfig.ROUTE_HOME_PAGE : (context) => HomePage(),
    RouteConfig.ROUTE_DAILY_PAGE : (context) => DailyPage(),
  };
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '冠云协同办公',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}


