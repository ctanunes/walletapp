// Define a custom Form widget.
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:testingflutterapp/models/budget.dart';
import 'package:testingflutterapp/models/budget_item.dart';
import 'package:testingflutterapp/services/db.dart';
import '../main.dart';

class GoalBody extends StatefulWidget {
  @override
  StateGoal createState() {
    return StateGoal();
  }
}
class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: new Stack(
          children: <Widget>[
            Card(
              child: Container(
                height: 100.0,
              ),
            ),
            FractionalTranslation(
              translation: Offset(0.0, -0.4),
              child: Align(
                child: CircleAvatar(
                  radius: 25.0,
                  child: Text("A"),
                ),
                alignment: FractionalOffset(0.5, 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Define a corresponding State class.
// This class holds data related to the form.
class StateGoal extends State<GoalBody> {
  double _counter = prefs.getDouble('counter') ?? 0;
  String _name;
  double _double;
  int _income;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  void _save() async {
    Budget item = Budget(
      name: _name,
      goal: _double,
    );
    print(item.toMap());
    await DB.insert(Budget.table, item);
    prefs.setDouble('counter', _counter + _double);
    setState(() => _double = null);
    setState(() => _name = '');
    Navigator.of(context).pop();
  }

// Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final myControllerNumber = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return CustomCard();
  }
}
