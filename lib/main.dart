import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register/register_page.dart';
import 'providers/session.dart';
import 'login/login.dart';
import 'home/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Session(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromRGBO(68, 189, 50,1.0),
          accentColor: Color.fromRGBO(76, 209, 55,1.0),
          textTheme: TextTheme(
            button: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
            title: TextStyle(color: Colors.white),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => Login(),
          HomePage.ROUTE_NAME: (ctx) => HomePage(),
          RegisterPage.ROUTE_NAME: (ctx) => RegisterPage()
        },
      ),
    );
  }
}
