import 'package:flutter/material.dart';

import 'foods_page.dart';
import 'orders_page.dart';
import 'transactions_page.dart';
import '../widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  static int currentBottomNavBarIndex = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: Theme.of(context).textTheme.title,),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: HomePage.currentBottomNavBarIndex,
        onTap: (i){
          setState(() {
            HomePage.currentBottomNavBarIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Foods'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Transactions'),
          ),
        ],
      ),
      body: IndexedStack(
        index: HomePage.currentBottomNavBarIndex,
        children: <Widget>[
          FoodsPage(),
          OrdersPage(),
          TransactionsPage(),
        ],
      ),
    );
  }
}
