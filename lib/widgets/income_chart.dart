import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../providers/transaction_point.dart';

class IncomeChart extends StatelessWidget {
  final List<TransactionPoint> incomePoints;

  IncomeChart({@required this.incomePoints});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TransactionPoint, DateTime>> series = [
      charts.Series(
          id: 'Income',
          data: incomePoints,
          domainFn: (TransactionPoint t, _) => t.date,
          measureFn: (TransactionPoint t, _) => t.income,
          colorFn: (TransactionPoint t, _) => t.barColor),
    ];

    return charts.TimeSeriesChart(series, animate: true);
  }
}
