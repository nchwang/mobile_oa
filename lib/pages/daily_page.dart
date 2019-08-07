import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  String _name;
  String _password;
  String _kaoQin;
  bool _isYuQi = false;
  DateTime _startDate = DateTime.now().toLocal();
  DateTime _endDate = DateTime.now().toLocal();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '项目名称',
                ),
                onSaved: (val) {
                  _name = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '行为科目',
                ),
                obscureText: true,
                validator: (val) {
                  return val.length < 4 ? "密码长度错误" : null;
                },
                onSaved: (val) {
                  _password = val;
                },
              ),
              _buildKaoQin(),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '地点',
                ),
                onSaved: (val) {
                  _name = val;
                },
              ),
              _buildDaiyDateTime(),
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

//  Widget _buildKaoQin() {
//    return Row(
//      children: <Widget>[
//        Flexible(child: Text("外勤")),
//        Flexible(
//          child: RadioListTile<String>(
//            value: '0',
//            title: Text('无'),
//            groupValue: _kaoqin,
//            onChanged: (value) {
//              setState(() {
//                _kaoqin = value;
//              });
//            },
//          ),
//        ),
//        Flexible(
//          child: RadioListTile<String>(
//            value: '1',
//            title: Text('外勤'),
//            groupValue: _kaoqin,
//            onChanged: (value) {
//              setState(() {
//                _kaoqin = value;
//              });
//            },
//          ),
//        ),
//        Flexible(
//          child: RadioListTile<String>(
//            value: '2',
//            title: Text('出差'),
//            groupValue: _kaoqin,
//            onChanged: (value) {
//              setState(() {
//                _kaoqin = value;
//              });
//            },
//          ),
//        ),
//      ],
//    );
//  }

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
              "是否预期:",
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

  Widget _buildDaiyDateTime() {
    return Container(
      child:  Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                          setState(() {
                            _startDate = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  child: Text(
                    '开始时间',
                    style: TextStyle(color: Colors.blue),
                  )),
              flex: 3,
            ),
            Expanded(
              child: Text('$_startDate'),
              flex: 8,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                          setState(() {
                            _endDate = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  child: Text(
                    '结束时间',
                    style: TextStyle(color: Colors.blue),
                  )),
              flex: 3,
            ),
            Expanded(
              child: Text('$_endDate'),
              flex: 8,
            ),
          ])
        ],
      )

    );
  }
}
