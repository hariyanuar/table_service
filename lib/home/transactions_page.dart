import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/transaction.dart' as TransactionModel;
import '../providers/session.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context, listen: false);

    return FutureBuilder(
      future: session.fetchTransactionsData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            var _transactions = snapshot.data as List<TransactionModel.Transaction>;

            return Scaffold(
              floatingActionButton: session.privilege == 'Administrator' ||
                      session.privilege == 'Kasir'
                  ? FloatingActionButton(
                      onPressed: () {},
                      heroTag: 'TransactionsPageFAB',
                    )
                  : null,
              body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: _transactions.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: GridTile(
                        child: Icon(Icons.attach_money, size: 100.0, color: Colors.grey,),
                        footer: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Text(_transactions[index].id),
                          subtitle: Text(DateFormat.yMMMMd()
                              .format(_transactions[index].orderdate)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
        return Center(child: Text('Something not good has happened'));
      },
    );
  }
}
