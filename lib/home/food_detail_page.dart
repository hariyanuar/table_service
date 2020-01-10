import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food.dart';
import '../providers/session.dart';

class FoodDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/food-detail-page';

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final Food loadedFood = session.getFoods.firstWhere((Food food) => food.id == (ModalRoute.of(context).settings.arguments as String));

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedFood.name),
      ),
      body: Center(child: Text('this is a food detail page')),
    );
  }
}
