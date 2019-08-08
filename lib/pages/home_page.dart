import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_oa/constant/route_config.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/cover.png"),
            fit: BoxFit.cover,
          ),
        ),

        child:Column(
          //测试Row对齐方式，排除Column默认居中对齐的干扰
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               _buildClickButton(context,'images/rizhi.png','日志',RouteConfig.ROUTE_DAILY_PAGE),
               _buildClickButton(context,'images/xietong.png','协同',RouteConfig.ROUTE_DAILY_PAGE)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildClickButton(context,'images/qingjia.png','请假',RouteConfig.ROUTE_DAILY_PAGE),
                _buildClickButton(context,'images/qiandao.png','签到',RouteConfig.ROUTE_DAILY_PAGE)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildClickButton(context,'images/shenpi.png','审批',RouteConfig.ROUTE_DAILY_PAGE),
                _buildClickButton(context,'images/jihua.png','计划',RouteConfig.ROUTE_DAILY_PAGE)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizedBox(height){
    return SizedBox(height: ScreenUtil.getInstance().setHeight(height));
  }

  Widget _buildClickButton(context,image,buttonName,routeName){
    return  InkWell(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(image),
          Positioned(
            bottom:4,
            left:2,
            child:Text(buttonName,
              style: new TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
              ),),
          )

        ],
      ),
      onTap: (){Navigator.of(context).pushNamed(routeName);}
    );
  }
}
