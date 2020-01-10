import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'auth.dart';
import 'food.dart';
import 'order.dart';
import 'transaction_point.dart';
import 'transaction.dart' as TransactionModel;

class Session with ChangeNotifier {
  final Auth auth = Auth();
  final Firestore database = Firestore.instance;

  String user_name;
  String privilege;

  List<Food> _foods = [];
  List<Order> _orders = [];
  List<TransactionModel.Transaction> _transactions = new List<TransactionModel.Transaction>();
  List<TransactionPoint> _transactionPoints = [];

  Future<void> fetchFoodsData() async {
    await database.collection('menus').getDocuments().then((documents) {
      _foods.clear();
      documents.documents.forEach((food) {
        _foods.add(Food(
          id: food.documentID,
          name: food.data['name'],
          price: food.data['price'],
          status: food.data['status'],
        ));
      });
    });
    notifyListeners();
  }

  get getFoods {
    return [..._foods];
  }

  Future<List<Order>> fetchOrdersData () async {
    final documents = await database.collection('orders').getDocuments();

    final users = await database.collection('users').getDocuments();

    String buyerName;

    _orders.clear();
    documents.documents.forEach((documentSnapshot){
      buyerName = users.documents.firstWhere((user) => user.documentID == documentSnapshot.data['uid']).data['user_name'];

      _orders.add(Order(
        id: documentSnapshot.documentID,
        note: documentSnapshot.data['note'],
        orderDate: documentSnapshot.data['orderdate'].toDate(),
        status: documentSnapshot.data['status'],
        tableNumber: documentSnapshot.data['tablenumber'],
        uid: documentSnapshot.data['uid'],
        name: buyerName,
      ));
    });

    return _orders;
  }

  get getOrders {
    return [..._orders];
  }

  Future<List<TransactionModel.Transaction>> fetchTransactionsData() async {
    final transactionSnapshot = await database.collection('transactions').getDocuments();
    final orders = await database.collection('orders').getDocuments();

    String uid;

    _transactions.clear();

    transactionSnapshot.documents.forEach((tx){
      uid = orders.documents.firstWhere((order) => order.documentID == tx.data['orderid']).data['uid'];

      _transactions.add(TransactionModel.Transaction(
        uid: uid,
        id: tx.documentID,
        orderdate: tx.data['orderdate'].toDate(),
        orderid: tx.data['orderid'],
        totalpayment: tx.data['totalpayment']
      ));
    });

    return _transactions;
  }

  get getTransactions {
    return [..._transactions];
  }
  
  Future<List<TransactionPoint>> fetchTransactionsReportData (BuildContext ctx) async {
    final transactions = await database.collection('transactions').where('orderdate', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now().subtract(Duration(days: 30)))).getDocuments();

    _transactionPoints.clear();
    transactions.documents.forEach((transaction){
      _transactionPoints.add(TransactionPoint(
        income: transaction.data['totalpayment'],
        date: transaction.data['orderdate'].toDate(),
        barColor: charts.ColorUtil.fromDartColor(Theme.of(ctx).primaryColor),
      ));
    });

    return _transactionPoints;
  }
}
