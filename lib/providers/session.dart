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
  List<TransactionModel.Transaction> _transactions = [];

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

  Future<void> fetchOrdersData() async {
    _orders.clear();
    await database.collection('orders').getDocuments().then((documents) async {
      documents.documents.forEach((order) {
        database
            .collection('users')
            .document(order.data['uid'])
            .get()
            .then((user) {
          _orders.add(Order(
            id: order.documentID,
            tableNumber: order.data['tablenumber'],
            orderDate: (order.data['orderdate'] as Timestamp).toDate(),
            status: order.data['status'],
            note: order.data['note'],
            uid: order.data['uid'],
            name: user.data['user_name'],
          ));
        });
      });
    });
    notifyListeners();
  }

  get getOrders {
    return [..._orders];
  }

  Future<void> fetchTransactionsData() async {
    _transactions.clear();
    await database
        .collection('transactions')
        .getDocuments()
        .then((documents) async {
      documents.documents.forEach((snapshot) {
        _transactions.add(TransactionModel.Transaction(
          id: snapshot.documentID,
          uid: snapshot.data['uid'],
          orderid: snapshot.data['orderid'],
          orderdate: snapshot.data['orderdate'].toDate(),
          totalpayment: snapshot.data['totalpayment']
        ));
      });
    });
    notifyListeners();
  }

  get getTransactions {
    return [..._transactions];
  }
}
