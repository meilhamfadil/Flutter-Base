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
  final AuthBloc auth = AuthBloc();

  bool _passwordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.appName),
        backgroundColor: AppColor.primary,
      ),
      body: Form(
        child: _form(),
        autovalidate: true,
      ),
    );
  }

  _form() => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: AppStyles.formLogin.copyWith(
                hintText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value.validateEmail().nullOrValue<String>("Email Not Valid"),
            ),
            Container(height: 10),
            TextFormField(
              decoration: AppStyles.formLogin.copyWith(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !_passwordShow ? AppColor.dark : AppColor.primary,
                    ),
                    onPressed: updateShowPasswordState,
                  )),
              obscureText: !_passwordShow,
              keyboardType: TextInputType.visiblePassword,
            ),
            Container(height: 10),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text("Login"),
                color: AppColor.primary,
                textColor: AppColor.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
      );

  void updateShowPasswordState() {
    setState(() {
      _passwordShow = !_passwordShow;
    });
  }

  @override
  void dispose() {
    super.dispose();
    auth.dispose();
  }
}
