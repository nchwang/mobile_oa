import 'package:flutter/material.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  String _name;
  String _password;
  String _kaoqin;
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
                  labelText: '开始时间',
                ),
                onSaved: (val) {
                  _name = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '结束时间',
                ),
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
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: '是否达到预期',
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

  Widget _buildKaoQin() {
    return Row(
      children: <Widget>[
        Flexible(child:Text("外勤")),
        Flexible(
          child: RadioListTile<String>(
            value: '0',
            title: Text('无'),
            groupValue: _kaoqin,
            onChanged: (value) {
              setState(() {
                _kaoqin = value;
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            value: '1',
            title: Text('外勤'),
            groupValue: _kaoqin,
            onChanged: (value) {
              setState(() {
                _kaoqin = value;
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            value: '2',
            title: Text('出差'),
            groupValue: _kaoqin,
            onChanged: (value) {
              setState(() {
                _kaoqin = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
