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
          primaryColor: Color.fromRGBO(247, 183, 49,1.0),
          accentColor: Color.fromRGBO(254, 211, 48,1.0),
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
