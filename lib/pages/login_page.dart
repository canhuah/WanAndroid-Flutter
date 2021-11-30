import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:wanAndroid/constant/constants.dart';
import 'package:wanAndroid/event/login_event.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/util/data_utils.dart';

//登录 键盘遮挡问题还没有解决 0_0
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _nameController =
      TextEditingController(text: 'canhuah');
  TextEditingController _passwordContro = TextEditingController(text: '111111');
  late GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    Row avatar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.account_circle,
          color: Theme.of(context).accentColor,
          size: 80.0,
        ),
      ],
    );

    // CupertinoButton(child: null, onPressed: null);

    TextField name = TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: "用户名",
      ),
      controller: _nameController,
    );

    TextField password = TextField(
      decoration: InputDecoration(labelText: "密码"),
      obscureText: true,

      controller: _passwordContro,
//      onChanged: ,
    );

    Row loginAndRegister = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          child: Text(
            "登录",
            style: TextStyle(
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
        RaisedButton(
          child: Text(
            "注册",
            style: TextStyle(
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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
        child: ListView(
          children: <Widget>[
            avatar,
            name,
            password,
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
            ),
            loginAndRegister,
          ],
        ),
      ),
    );
  }

  void _login() {
    String name = _nameController.text;
    String password = _passwordContro.text;
    if (name.isEmpty) {
      _showMessage('请先输入姓名');
      return;
    }
    if (password.isEmpty) {
      _showMessage('请先输入密码');
      return;
    }

    ApiManager.instance.login(name, password, successCallback: () {
      DataUtils.saveLoginInfo(name).then((r) {
        Constants.eventBus.fire(LoginEvent());
        Navigator.of(context).pop();
      });
    });
  }

  void _register() {
    String name = _nameController.text;
    String password = _passwordContro.text;
    if (name.isEmpty) {
      _showMessage('请先输入姓名');
      return;
    }
    if (password.isEmpty) {
      _showMessage('请先输入密码');
      return;
    }
    Map<String, String> map = Map();
    map['username'] = name;
    map['password'] = password;
    map['repassword'] = password;

    ApiManager.instance.register(name, password, successCallback: () {
      DataUtils.saveLoginInfo(name).then((r) {
        Constants.eventBus.fire(LoginEvent());
        Navigator.of(context).pop();
      });
    });
  }

  void _showMessage(String msg) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(msg)));
  }
}
