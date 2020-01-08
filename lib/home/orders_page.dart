import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_service/providers/order.dart';

import '../providers/session.dart';

class OrdersPage extends StatefulWidget {
  bool isLoading = true;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> _orders = [];

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);

    if (widget.isLoading) {
      session.fetchOrdersData().then((_) {
        _orders.clear();
        setState(() {
          widget.isLoading = false;
        });
        _orders = session.getOrders;
      });
    }

    return Scaffold(
      floatingActionButton: session.privilege == 'Administrator' ||
              session.privilege == 'Waiter' ||
              session.privilege == 'Customer'
          ? FloatingActionButton(
              heroTag: 'OrdersPageFAB',
              onPressed: () {},
              child: Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
              ),
              itemCount: _orders.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: GridTile(
                      child: Icon(
                        Icons.library_books,
                        size: 100.0,
                        color: Colors.grey,
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text('Order by: ${_orders[i].name}'),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
