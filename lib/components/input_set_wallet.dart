
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences prefs;
class InputSetWallet extends StatelessWidget {
  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: _asyncInputDialog(context),
        builder: (context, AsyncSnapshot<String> snapshot) {
            return Text(snapshot.data);
        }
    );
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    String wallet_value = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter current value in your wallet'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Set wallet value', hintText: '1234'),
                    onChanged: (value) {
                      wallet_value = value;
                    },
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop('cancel');
              },
            ),
            FlatButton(
              child: Text('SET'),
              onPressed: () async {
                // obtain shared preferences
                prefs = await SharedPreferences.getInstance();
                double to_set_value = double.parse(wallet_value);
                prefs.setDouble('counter', to_set_value);
                prefs.setDouble('start_value', to_set_value);
                Navigator.of(context).pop(wallet_value);
              },
            ),
          ],
        );
      },
    );
  }

}