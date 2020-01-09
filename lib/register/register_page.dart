import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_service/home/homepage.dart';

import '../providers/session.dart';
import '../widgets/my_drawer.dart';
import '../widgets/custom_raised_button.dart';

class RegisterPage extends StatefulWidget {
  static const ROUTE_NAME = '/register';

  bool isLoading = false;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userLevel;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmPasswordFocusNode = FocusNode();

  final _passwordController = new TextEditingController();

  final _form = GlobalKey<FormState>();

  var _userRegisterData = {};

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Page',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
      body: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    (AppBar()).preferredSize.height,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0.0,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 600,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        elevation: 7.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 45.0),
                          child: Form(
                            key: _form,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context)
                                        .requestFocus(_emailFocusNode);
                                  },
                                  validator: (val) {
                                    if (val.trim().isEmpty)
                                      return 'Name should not be empty!';

                                    return null;
                                  },
                                  onSaved: (val) {
                                    _userRegisterData['name'] = val.trim();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'Full Name',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: _emailFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                  validator: (val) {
                                    if (RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val.trim()))
                                      return null;
                                    else
                                      return 'Invalid email address!';
                                  },
                                  onSaved: (val) {
                                    _userRegisterData['email'] = val.trim();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context).requestFocus(
                                        _passwordConfirmPasswordFocusNode);
                                  },
                                  validator: (val) {
                                    if (val.trim().length < 6)
                                      return 'Password should at least 6 characters';

                                    return null;
                                  },
                                  onSaved: (val) {
                                    _userRegisterData['password'] = val.trim();
                                    _passwordController.clear();
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  focusNode: _passwordConfirmPasswordFocusNode,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  validator: (val) {
                                    if (_passwordController.text != val.trim())
                                      return 'Password confirmation does not match!';
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    labelText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                DropdownButtonFormField(
                                  value: userLevel,
                                  onChanged: (value) {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    setState(() {
                                      userLevel = value;
                                    });
                                  },
                                  validator: (val) {
                                    if (val == null)
                                      return 'Please select User Privilege';

                                    return null;
                                  },
                                  onSaved: (val) {
                                    _userRegisterData['privilege'] = val;
                                    userLevel = null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Select user Privilege',
                                    contentPadding: EdgeInsets.all(5.0),
                                    prefixIcon: Icon(Icons.contacts),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                        child: Text('Adminstrator'),
                                        value: 'LV001'),
                                    DropdownMenuItem(
                                        child: Text('Waiter'), value: 'LV002'),
                                    DropdownMenuItem(
                                        child: Text('Kasir'), value: 'LV003'),
                                    DropdownMenuItem(
                                        child: Text('Owner'), value: 'LV004'),
                                    DropdownMenuItem(
                                        child: Text('Customer'),
                                        value: 'LV005'),
                                  ],
                                ),
                                SizedBox(height: 75.0),
                                CustomRaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.isLoading = true;
                                    });

                                    if (_form.currentState.validate()) {
                                      _form.currentState.save();
                                      session.auth
                                          .signUp(_userRegisterData['email'],
                                              _userRegisterData['password'])
                                          .then((uid) {
                                        session.auth
                                            .signIn(_userRegisterData['email'],
                                                _userRegisterData['password'])
                                            .then((_) {
                                          session.auth.sendEmailVerification();
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text('You have been registered!', style: TextStyle(color: Colors.black),),
                                                content: Text(
                                                    'We have sent you email verification, please follow given instruction on the email.'),
                                                actions: <Widget>[
                                                  FlatButton(child: Text('Ok'), onPressed: () => Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME),)
                                                ],
                                              ));
                                        });
                                        session.database.collection('users').document(uid).setData({
                                          'user_name': _userRegisterData['name'],
                                          'privilege': _userRegisterData['privilege']
                                        });
                                      }).catchError((err) {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text('Sorry!', style: TextStyle(color: Colors.black),),
                                            content: Text(err.message),
                                            actions: <Widget>[
                                              FlatButton(child: Text('Ok'), onPressed: () => Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME)),
                                            ],
                                          ),
                                        );
                                        setState(() {
                                          widget.isLoading = false;
                                        });
                                      });
                                    }
                                  },
                                  child: Text('Register'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
