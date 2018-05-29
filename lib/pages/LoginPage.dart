import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtil.dart';
import 'package:wanAndroid/util/DataUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _nameContro = new TextEditingController();
  TextEditingController _passwordContro = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Row avatar = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.account_circle,
          color: Colors.blue,
          size: 80.0,
        ),
      ],
    );

    TextField name = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        labelText: "用户名",
      ),
      controller: _nameContro,
    );

    TextField password = new TextField(
      decoration: InputDecoration(labelText: "密码"),
      obscureText: true,

      controller: _passwordContro,
//      onChanged: ,
    );

    Row loginAndRegister = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new RaisedButton(
          child: new Text(
            "登录",
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blue,
          disabledColor: Colors.blue,
          textColor: Colors.white,
          onPressed: (){
            _login();
          },
        ),
        new RaisedButton(
          child: new Text(
            "注册",
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blue,
          disabledColor: Colors.blue,
          textColor: Colors.white,
          onPressed: (){
            _register();
          },
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('登录'),
      ),
      body: new Padding(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
        child: new ListView(
          children: <Widget>[
            avatar,
            name,
            password,
            new Padding(
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
            ),
            loginAndRegister,
          ],
        ),
      ),
    );
  }

  _login() {
    String name = _nameContro.text;
    String password = _passwordContro.text;
    if (name.length == 0) {
      _showMessage('请先输入姓名');
      return;
    }
    if (password.length == 0) {
      _showMessage('请先输入密码');
      return;
    }
    Map<String,String> map = new Map();
    map['username'] = name;
    map['password'] = password;

    HttpUtil.post(Api.LOGIN, (data) {

      DataUtils.saveLoginInfo();
//      Navigator.of(context).pop();
//      _showMessage('登录 成功');
    },
        params: map,
        errorCallback: (msg) {
      _showMessage(msg);
    });
  }
  _register() {
    String name = _nameContro.text;
    String password = _passwordContro.text;
    if (name.length == 0) {
      _showMessage('请先输入姓名');
      return;
    }
    if (password.length == 0) {
      _showMessage('请先输入密码');
      return;
    }
    Map<String,String> map = new Map();
    map['username'] = name;
    map['password'] = password;
    map['repassword'] = password;

    HttpUtil.post(Api.REGISTER,(data) {
      Navigator.of(context).pop();
    },
        params: map,
        errorCallback: (msg) {
      _showMessage(msg);
    });
  }




  Future<Null> _showMessage(String msg) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }
}
