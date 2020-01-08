import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/food.dart';
import '../providers/session.dart';

class FoodsPage extends StatefulWidget {
  bool isLoading = true;

  @override
  _FoodsPageState createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  List<Food> _foods = [];

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);

    if (widget.isLoading) {
      session.fetchFoodsData().then((_) {
        _foods.clear();
        setState(() {
          widget.isLoading = false;
        });
        _foods = session.getFoods;
      });
    }

    return Scaffold(
      floatingActionButton: session.privilege == 'Administrator' ? FloatingActionButton(
        heroTag: 'FoodsPageFAB',
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ) : null,
      body: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
              ),
              itemCount: _foods.length,
              itemBuilder: (ctx, i){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: GridTile(
                      child: Icon(Icons.fastfood, size: 100.0, color: Colors.grey),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(_foods[i].name, textAlign: TextAlign.center),
                        subtitle: Text(NumberFormat.currency(locale: 'ID').format(_foods[i].price), textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
