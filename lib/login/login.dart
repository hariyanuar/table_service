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
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/login.png',
                width: MediaQuery.of(context).size.width * 0.35),
            SizedBox(height: MediaQuery.of(context).size.height * 0.075),
            CustomTextField(
              labelText: 'Email',
              controller: _emailController,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomTextField(
              labelText: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomRaisedButton(
              onPressed: () {
                final session = Provider.of<Session>(context, listen: false);

                session.auth
                    .signIn(_emailController.text, _passwordController.text)
                    .then((uid) {
                      session.database.collection('users').document(uid).get().then((document){
                        session.user_name = document.data['user_name'];
                        session.database.collection('levels').document(document.data['privilege']).get().then((document){
                          session.privilege = document.data['levelname'];
                          Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
                        });
                      });
                })
                    .catchError((err) {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(err.message)));
                });
              },
              child: Text(
                'LOGIN',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          ],
        ),
      ),
    );
  }
}
