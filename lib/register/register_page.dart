import 'package:flutter/material.dart';

import '../widgets/my_drawer.dart';

class RegisterPage extends StatelessWidget {
  static const ROUTE_NAME = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height * 0.375,
            width: MediaQuery.of(context).size.width,
            child: Material(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200.0)),
              elevation: 7.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(200.0)),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.height * 0.06,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.35,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
