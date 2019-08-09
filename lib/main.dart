import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/home_page.dart';
import './pages/daily_page.dart';
import './pages/weekly_page.dart';
import 'package:mobile_oa/constant/route_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    RouteConfig.ROUTE_LOGIN_PAGE : (context) => LoginPage(),
    RouteConfig.ROUTE_HOME_PAGE : (context) => HomePage(),
    RouteConfig.ROUTE_DAILY_PAGE : (context) => DailyPage(),
    RouteConfig.ROUTE_PLAN_PAGE : (context) => WeeklyPage(),
  };
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '冠云协同办公',
      theme: ThemeData(
        primarySwatch: Colors.blue,
          fontFamily: 'Microsoft Yahei',
      ),
        localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //此处
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
      home: LoginPage(),
      routes: routes,
    );
  }
}


