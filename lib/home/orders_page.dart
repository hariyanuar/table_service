import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../providers/session.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context, listen: false);

    return FutureBuilder(
      future: session.fetchOrdersData(),
      builder: (ctx, snapshot) {
        var _orders = snapshot.data as List<Order>;

        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: _orders.length,
            itemBuilder: (ctx, index){
              return GridTile(
                child: Icon(Icons.library_books),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(_orders[index].id),
                  subtitle: Text('Order by ${_orders[index].name}'),
                ),
              );
            },
          );
        } else {
          return Center(child: Text(snapshot.error.toString()));
        }
      },
    );
  }
}
