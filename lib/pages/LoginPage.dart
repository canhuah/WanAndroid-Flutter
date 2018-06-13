import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/Constants.dart';
import 'package:wanAndroid/event/LoginEvent.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtilWithCookie.dart';
import 'package:wanAndroid/util/DataUtils.dart';

//登录 键盘遮挡问题还没有解决 0_0
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _nameContro =
      new TextEditingController(text: 'canhuah');
  TextEditingController _passwordContro =
      new TextEditingController(text: 'a123456');
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    Row avatar = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.account_circle,
          color: Theme.of(context).accentColor,
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
          color: Theme.of(context).accentColor,
          disabledColor: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
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
          onPressed: () {
            _register();
          },
        ),
      ],
    );

    return new Scaffold(
      key: scaffoldKey,
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

  void _login() {
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
    Map<String, String> map = new Map();
    map['username'] = name;
    map['password'] = password;

    HttpUtil.post(
        Api.LOGIN,
        (data) async {
          DataUtils.saveLoginInfo(name).then((r) {
            Constants.eventBus.fire(new LoginEvent());
            Navigator.of(context).pop();
          });
        },
        params: map,
        errorCallback: (msg) {
          _showMessage(msg);
        });
  }

  void _register() {
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
    Map<String, String> map = new Map();
    map['username'] = name;
    map['password'] = password;
    map['repassword'] = password;

    HttpUtil.post(
        Api.REGISTER,
        (data) async {
          DataUtils.saveLoginInfo(name).then((r) {
            Constants.eventBus.fire(new LoginEvent());
            Navigator.of(context).pop();
          });
        },
        params: map,
        errorCallback: (msg) {
          _showMessage(msg);
        });
  }

  void _showMessage(String msg) {

    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(msg)));
  }
}
