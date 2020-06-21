import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testingflutterapp/services/db.dart';

SharedPreferences prefs;

class InputResetAll extends StatelessWidget {
  @override
  Widget build(context) {
    return FutureBuilder<void>(
        future: _asyncInputDialog(context),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<void> snapshot) {
        });
  }

  void _save() async {
    DB.deleteData();
  }

  Future<void> _asyncInputDialog(BuildContext context) async {
    String wallet_value = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You can delete all you data.'),
                Text('This will delete your goals and all your budget items'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('APPROVE'),
              onPressed: () {
                _save();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
