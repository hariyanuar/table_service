class Order {
  final String id;
  final String name;
  final String uid;
  final int tableNumber;
  String status;
  final DateTime orderDate;
  final String note;

  Order({this.name, this.id, this.uid, this.tableNumber, this.orderDate, this.note, this.status});
}