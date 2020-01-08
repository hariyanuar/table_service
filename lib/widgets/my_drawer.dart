import 'package:flutter/material.dart';

import '../home/homepage.dart';
import '../register/register_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: DrawerHeader(
              child: Text('Welcome to Table Service App', style: Theme.of(context).textTheme.title,),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey),),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
            },
          ),
          Divider(endIndent: 50.0, indent: 10.0,),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Register User', style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey),),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RegisterPage.ROUTE_NAME);
            },
          ),
          Divider(endIndent: 50.0, indent: 10.0,),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Report', style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey),),
          ),
          Divider(endIndent: 50.0, indent: 10.0,),
        ],
      ),
    );
  }
}
