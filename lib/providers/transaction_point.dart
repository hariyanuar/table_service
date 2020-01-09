import 'package:charts_flutter/flutter.dart' as charts;

class TransactionPoint {
  final DateTime date;
  final int income;
  final charts.Color barColor;

  TransactionPoint({this.date, this.income, this.barColor});
}