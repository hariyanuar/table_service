class Transaction {
  final String id;
  final String orderid;
  final DateTime orderdate;
  final int totalpayment;
  final String uid;

  Transaction({this.id, this.orderid, this.orderdate, this.totalpayment, this.uid});
}