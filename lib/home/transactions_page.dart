import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/session.dart';
import '../providers/transaction.dart' as TransactionModel;

class TransactionsPage extends StatefulWidget {
  bool isLoading = true;
  List<TransactionModel.Transaction> _transactions = [];

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  QuerySnapshot buyerName;

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);

    session.fetchTransactionsData().then((_) async {
      widget._transactions.clear();

      widget._transactions = session.getTransactions;

      buyerName = await session.database
          .collection('users').getDocuments();

      setState(() {
        widget.isLoading = false;
      });
    });

    return widget.isLoading ? Center(child: CircularProgressIndicator()) : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: widget._transactions.length,
      itemBuilder: (ctx, i) {
        return Card(
          child: GridTile(
            child: Icon(
              Icons.attach_money,
              size: 100.0,
              color: Colors.grey,
            ),
            footer: GridTileBar(
              title: Text(widget._transactions[i].id),
              subtitle: Text('Order by ${buyerName.documents.where((buyer) => buyer.documentID == widget._transactions[i].uid).first.data['user_name']}'),
              backgroundColor: Colors.black54,
            ),
          ),
        );
      },
    );
  }
}
