import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(new LoginWidget());

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  GlobalKey<FormState> _loginState = GlobalKey<FormState>();

  String _userName;
  String _password;

  void _login() {
    var state = _loginState.currentState;
    if (state.validate()) {
      state.save();
      Scaffold.of(state.context).showSnackBar(SnackBar(
          content: Text('_userName====$_userName+++_password=====$_password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '表单提交',
        home: Scaffold(
          appBar: AppBar(
            title: Text('表单提交'),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Form(
                    key: _loginState,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: '请输入用户名'),
                          onSaved: (value) {
                            print('onSave');
                            _userName = value;
                          },
                          onFieldSubmitted: (value) {
                            print('onFieldSubmitted');
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: '请输入密码'),
                          onSaved: (value) {
                            print('onSave');
                            _password = value;
                          },
                          onFieldSubmitted: (value) {
                            print('onFieldSubmitted');
                          },
                          obscureText: true,
                          validator: (value) {
                            return value.length < 6 ? '密码最少6位' : null;
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          width: 300,
                          height: 45,
                          child: RaisedButton(
                            child: Text('登陆'),
                            onPressed: () {
                              _login();
                            },
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
