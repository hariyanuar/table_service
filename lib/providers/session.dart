import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'food.dart';
import 'order.dart';
import 'transaction.dart' as TransactionModel;

class Session with ChangeNotifier {
  final Auth auth = Auth();
  final Firestore database = Firestore.instance;

  String user_name;
  String privilege;

  List<Food> _foods = [];
  List<Order> _orders = [];
  List<TransactionModel.Transaction> _transactions = new List<TransactionModel.Transaction>();

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
    final transactions = await database.collection('transactions').getDocuments();
    final orders = await database.collection('orders').getDocuments();

    String uid;

    _transactions.clear();

    transactions.documents.forEach((transaction){
      uid = orders.documents.firstWhere((order) => order.documentID == transaction.data['orderid']).data['uid'];

      _transactions.add(TransactionModel.Transaction(
        uid: uid,
        id: transaction.documentID,
        orderdate: transaction.data['orderdate'].toDate(),
        orderid: transaction.data['orderid'],
        totalpayment: transaction.data['totalpayment']
      ));
    });

    return _transactions;
  }

  get getTransactions {
    return [..._transactions];
  }
}
