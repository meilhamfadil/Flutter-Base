import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/presentation/auth/auth_bloc.dart';
import 'package:flutterfirebase/resource/color.dart';
import 'package:flutterfirebase/resource/string.dart';
import 'package:flutterfirebase/resource/styles.dart';

class MainApps extends StatefulWidget {
  @override
  State createState() => _MainApps();
}

class _MainApps extends State<MainApps> {
  bool _isVisiblePassword = false;
  bool _isRequesting = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthBloc auth = AuthBloc();

  _updatePasswordVisibility() =>
      setState(() => _isVisiblePassword = !_isVisiblePassword);

  _updateRequestStatus(bool value) => setState(() => _isRequesting = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.appName),
        backgroundColor: AppColor.primary,
      ),
      body: StreamBuilder(
        stream: auth.currentUser,
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.data == null)
            return Form(
              key: _formKey,
              child: _form(),
            );

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Email Anda :"),
                Text(snapshot.data.email),
                Text("ID anda : "),
                Text(snapshot.data.uid)
              ],
            ),
          );
        },
      ),
    );
  }

  _form() => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: auth.tecEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: AppStyles.formLogin.copyWith(
                hintText: "Email",
              ),
              validator: (value) => value
                  .validation()
                  .required(message: "Email Required")
                  .email(message: "Email Not Valid")
                  .validate(),
            ),
            Container(height: 10),
            TextFormField(
              controller: auth.texPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isVisiblePassword,
              validator: (value) => value
                  .validation()
                  .required(message: "Password Required")
                  .minLength(
                    length: 6,
                    message: "Password At Least 6 Character",
                  )
                  .validate(),
              decoration: AppStyles.formLogin.copyWith(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color:
                          _isVisiblePassword ? AppColor.primary : AppColor.dark,
                    ),
                    onPressed: _updatePasswordVisibility,
                  )),
            ),
            StreamBuilder(
              stream: auth.loginMessage,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData)
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(snapshot.data),
                  );
                return Container();
              },
            ),
            Container(height: 10),
            Container(
              width: double.infinity,
              child: loginButton(),
            ),
          ],
        ),
      );

  FlatButton loginButton() {
    return FlatButton(
      child: (!_isRequesting) ? Text("Login") : AppWidget.smallLoading,
      color: AppColor.primary,
      disabledColor: AppColor.secondary,
      textColor: AppColor.white,
      onPressed: onSubmit(),
    );
  }

  Function onSubmit() {
    if (_isRequesting) return null;

    return () async {
      if (_formKey.currentState.validate()) {
        _updateRequestStatus(true);
        await auth.signIn();
        _updateRequestStatus(false);
      }
    };
  }
}
