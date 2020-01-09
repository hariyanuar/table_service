import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/homepage.dart';
import '../providers/session.dart';
import '../widgets/custom_raised_button.dart';
import '../widgets/custom_text_field.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  bool isLoading = false;

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.isLoading ? Center(child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text('Wait for a moment')
      ],)) : SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height - MediaQuery
            .of(context)
            .padding
            .top,
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/login.png',
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.35),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.075),
            CustomTextField(
              labelText: 'Email',
              controller: _emailController,
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.025),
            CustomTextField(
              labelText: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.025),
            CustomRaisedButton(
              onPressed: () {
                setState(() {
                  widget.isLoading = true;
                });

                final session = Provider.of<Session>(context, listen: false);
                session.auth
                    .signIn(_emailController.text.trim(),
                    _passwordController.text.trim())
                    .then((uid) {
                  session.auth.isEmailVerified().then((isEmailVerified) {
                    if (!isEmailVerified)
                      showDialog(context: context, builder: (ctx) =>
                          AlertDialog(
                            title: Text('Your email is not verified yet!'),
                            content: Text(
                                'If you\'re not receiving any email, we suggest checking the spam.'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Resend email verification'),
                                onPressed: () {
                                  session.auth.sendEmailVerification();
                                  setState(() {
                                    widget.isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(child: Text('Ok'),
                                onPressed: () => Navigator.of(context).pop(),),
                            ],
                          ));
                    else
                      session.database.collection('users').document(uid)
                          .get()
                          .then((document) {
                        session.user_name = document.data['user_name'];
                        session.database.collection('levels').document(
                            document.data['privilege']).get().then((document) {
                          session.privilege = document.data['levelname'];
                          Navigator.of(context).pushReplacementNamed(
                              HomePage.ROUTE_NAME);
                        });
                      });
                  });
                })
                    .catchError((err) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(err.message)));
                  setState(() {
                    widget.isLoading = false;
                  });
                });
              },
              child: Text(
                'LOGIN',
                style: Theme
                    .of(context)
                    .textTheme
                    .button,
              ),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.025),
          ],
        ),
      ),
    );
  }
}
