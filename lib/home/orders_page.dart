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
          return Scaffold(
            floatingActionButton: session.privilege == 'Administrator' ||
                    session.privilege == 'Waiter' ||
                    session.privilege == 'Customer'
                ? FloatingActionButton(
                    onPressed: () {},
                    heroTag: 'OrdersPageFAB',
                  )
                : null,
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: _orders.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: GridTile(
                      child: Icon(Icons.library_books, size: 100.0, color: Colors.grey,),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(_orders[index].id),
                        subtitle: Text('Order by ${_orders[index].name}'),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text(snapshot.error.toString()));
        }
      },
    );
  }
}
