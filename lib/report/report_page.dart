import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/session.dart';
import '../widgets/income_chart.dart';
import '../widgets/my_drawer.dart';

class ReportPage extends StatefulWidget {
  static const ROUTE_NAME = '/reports';

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
          future: session.fetchTransactionsReportData(context),
          builder: (ctx, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));
            else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Income by the last month',
                        style: Theme.of(context).textTheme.headline,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 400,
                        child: IncomeChart(
                          incomePoints: snapshot.data,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
