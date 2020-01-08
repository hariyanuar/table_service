import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const CustomRaisedButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.5),
      onPressed: onPressed,
      child: child,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    );
  }
}
