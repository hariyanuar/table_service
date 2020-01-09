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
          DrawerHeader(
            padding: EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(child: Text('Welcome to Table Service App', style: Theme.of(context).textTheme.title,)),
          ),
          Divider(endIndent: 10.0, indent: 10.0, thickness: 1.5,),
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
