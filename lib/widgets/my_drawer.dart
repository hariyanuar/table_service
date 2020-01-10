import 'package:flutter/material.dart';

import '../report/report_page.dart';
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
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home', style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey),),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Register User', style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey),),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RegisterPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Report', style: Theme.of(context).textTheme.button.copyWith(color: Colors.grey),),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(ReportPage.ROUTE_NAME);
            },
          ),
          Divider(thickness: 1.5,),
        ],
      ),
    );
  }
}
