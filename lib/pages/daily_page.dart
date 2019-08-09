import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mobile_oa/utils/shared_preferences_utils.dart';
import 'package:mobile_oa/utils/dio_utils.dart';
import 'package:mobile_oa/constant/api_config.dart';
import 'package:mobile_oa/model/user_project.dart';
import 'package:mobile_oa/utils/date_format.dart';
import 'package:flutter_picker/flutter_picker.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  String _name;
  String _password;
  String _kaoQin;
  String _projectId;
  String _actionId;

  bool _isYuQi = false;
  DateTime _dailyDate = DateTime.now();
  List<String> _startTime = ['00','00'];
  List<String> _endTime = ['00','00'];
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<UserProject> projectList = [];
  List<UserAction> actionList = [];

  String convertDateTime(DateTime dt){
    if(dt != null){

    }
  }
  @override
  void initState(){
    /**
     * 获取用户有权填写的项目
     */
    _getUserProjectList();
    /**
     * 获取用户的行为列表
     */
    _getUserActionList();
  }

  //页面加载时获得当前用户的Action和
  void _getUserProjectList() async{
    String userId = await SharedPreferencesUtils.getString('id');
    //print('Current user id is : ' + userId);
    var formData = {
      'user_id': userId
    };

    await DioUtils.getInstance().request(ProjectApi.project_list,formData: formData).then((val){
      try{
        var decode = val['data'];
        decode['items'].forEach((v) {
          //print("The result is " + v['id'].toString());
          UserProject up = new UserProject(projectId:v['id'],projectName:v['name']);
          //print(up);
          setState((){
            projectList.add(up);
          });
        });
      }on FormatException catch(e){
        print('error ${e.toString()}');
      }

    });
  }

 //后台返回数据格式为{items: [{value: 1, label: 营销类, children: [{value: 16, label: 登门拜访}
  void _getUserActionList() async{

    await DioUtils.getInstance().request(ProjectApi.project_action).then((val){
      try{
        var data = val['items'][0]['children'];
        if(data != null){
          data.forEach((v){
            //print(v);
            UserAction ua = new UserAction(actionValue:v['value'],actionName:v['label']);
            //print(up);
            setState((){
              actionList.add(ua);
            });
          });
        }
      }on FormatException catch(e){
        print('error ${e.toString()}');
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('我的日志'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _forSubmitted,
        child: new Text('提交'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16),
        child: new Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              _buildProjectInfo(),
              _buildActionCodeList(),
              _buildKaoQin(),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '地点',
                ),
                onSaved: (val) {
                  _name = val;
                },
              ),
              _buildDaiyDateTime(context),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '为何要做',
                  hintText: '字数不超过200',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                maxLength: 200,
                maxLines: 2,
                onSaved: (val) {
                  _name = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '做了什么',
                  hintText: '字数不超过500',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                maxLength: 500,
                maxLines: 5,
                onSaved: (val) {
                  _name = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '做的如何',
                ),
                onSaved: (val) {
                  _name = val;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _forSubmitted() {
    var _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      print(_name);
      print(_password);
    }
  }

  _showStartTime(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              begin: 0,
              end: 24,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }
          ),
          NumberPickerColumn(
              begin: 0,
              end: 30,
              jump:30,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }
          ),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: Text("Please Select"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            List<String> temp = [];
            picker.getSelectedValues().forEach((v){
              temp.add(v<10? "0$v" : "$v");});
            _startTime = temp;
          });
        }
    ).showDialog(context);
  }


  _showEndTime(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              begin: 0,
              end: 24,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }
          ),
          NumberPickerColumn(
              begin: 0,
              end: 30,
              jump:30,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }
          ),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: Text("Please Select"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          //print(picker.getSelectedValues());
          setState(() {
            List<String> temp = [];
            picker.getSelectedValues().forEach((v){
              temp.add(v<10? "0$v" : "$v");});
            //print(temp);
            _endTime = temp;
            //print(_endTime);
          });
        }
    ).showDialog(context);
  }


  List<DropdownMenuItem> _getProjectData() {
    List<DropdownMenuItem> items = new List();
    projectList.forEach((v){
      DropdownMenuItem dropdownMenuItem = new DropdownMenuItem(
        child: new Text('${v.projectName}'),
        value: '${v.projectId}',
        
      );
      items.add(dropdownMenuItem);
    });

    return items;
  }

  List<DropdownMenuItem> _getActionCodeData() {
    List<DropdownMenuItem> items = new List();
    actionList.forEach((v){
      DropdownMenuItem dropdownMenuItem = new DropdownMenuItem(
        child: new Text('${v.actionName}'),
        value: '${v.actionValue}',
      );
      items.add(dropdownMenuItem);
    });

    return items;
  }

  Widget _buildProjectInfo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Expanded(
//            child: Text(
//              "项目:",
//              style: TextStyle(fontSize: 16),
//            ),
//          ),
          Expanded(
            child: DropdownButton(
              items: _getProjectData(),
              hint: new Text('选择项目'), //当没有默认值的时候可以设置的提示
              value: _projectId, //下拉菜单选择完之后显示给用户的值
              onChanged: (T) {
                //下拉菜单item点击之后的回调
                setState(() {
                  _projectId = T;
                });
              },
              elevation: 24, //设置阴影的高度
              style: new TextStyle(
                //设置文本框里面文字的样式
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionCodeList() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Expanded(
//            child: Text(
//              "项目:",
//              style: TextStyle(fontSize: 16),
//            ),
//          ),
          Expanded(
            child: DropdownButton(
              items: _getActionCodeData(),
              hint: new Text('选择行为科目'), //当没有默认值的时候可以设置的提示
              value: _actionId, //下拉菜单选择完之后显示给用户的值
              onChanged: (T) {
                //下拉菜单item点击之后的回调
                setState(() {
                  _actionId = T;
                });
              },
              elevation: 24, //设置阴影的高度
              style: new TextStyle(
                //设置文本框里面文字的样式
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }



  List<DropdownMenuItem> _getKaoQinListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('无'),
      value: '0',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('外勤'),
      value: '1',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text('请假'),
      value: '2',
    );
    items.add(dropdownMenuItem3);
    return items;
  }

  Widget _buildKaoQin() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              "考勤:",
              style: TextStyle(fontSize: 16),
            ),
            flex: 3,
          ),
          Expanded(
            child: DropdownButton(
              items: _getKaoQinListData(),
              hint: new Text('考勤类型'), //当没有默认值的时候可以设置的提示
              value: _kaoQin, //下拉菜单选择完之后显示给用户的值
              onChanged: (T) {
                //下拉菜单item点击之后的回调
                setState(() {
                  _kaoQin = T;
                });
              },
              elevation: 24, //设置阴影的高度
              style: new TextStyle(
                  //设置文本框里面文字的样式
                  color: Colors.red),
            ),
            flex: 5,
          ),
          Expanded(
            child: Text(
              "是否达到预期:",
              style: TextStyle(fontSize: 16),
            ),
            flex: 4,
          ),
          Expanded(
            child: Switch(
              value: _isYuQi,
              onChanged: (newValue) {
                setState(() {
                  _isYuQi = newValue;
                });
              },
              activeColor: Colors.red,
              activeTrackColor: Colors.black,
              inactiveThumbColor: Colors.green,
              inactiveTrackColor: Colors.blue,
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildIsYuQi() {
    return Row(children: <Widget>[
      Text('是否达到预期'),
      Switch(
        value: _isYuQi,
        onChanged: (newValue) {
          setState(() {
            _isYuQi = newValue;
          });
        },
        activeColor: Colors.red,
        activeTrackColor: Colors.black,
        inactiveThumbColor: Colors.green,
        inactiveTrackColor: Colors.blue,
      )
    ]);
  }

  Widget _buildDaiyDateTime(BuildContext context) {
    return Container(
      child:  Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              child: Text('时间'),
              flex: 2,
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                          setState(() {
                            _dailyDate = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  child: Text(
                    (formatDate(_dailyDate,[yyyy, '-', mm, '-', dd])),
                    style: TextStyle(color: Colors.blue),
                  )),
              flex: 5,
            ),
            Expanded(
              child: Text('从'),
              flex: 1,
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    _showStartTime(context);
                  },
                  child: Text(_startTime[0]+ ':' + _startTime[1],
                    style: TextStyle(color: Colors.blue),
                  )),
              flex: 4,
            ),
            Expanded(
              child: Text('到'),
              flex: 1,
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    _showEndTime(context);
                  },
                  child: Text(_endTime[0]+ ':' + _endTime[1],
                    style: TextStyle(color: Colors.blue),
                  )),
              flex: 4,
            ),
          ]),
        ],
      )

    );
  }
}
