// Define a custom Form widget.
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testingflutterapp/models/budget_item.dart';
import 'package:testingflutterapp/models/budget_items_list.dart';
import 'package:testingflutterapp/services/db.dart';

import '../main.dart';

class MyCustomFormGoalExpense extends StatefulWidget {
  MyCustomFormGoalExpense(this.id);

  final int id;
  @override
  MyCustomFormStateGoalExpense createState() {
    return MyCustomFormStateGoalExpense(this.id);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormStateGoalExpense extends State<MyCustomFormGoalExpense> {
  double _counter = prefs.getDouble('counter') ?? 0;
  String _name;
  double _double;
  bool _income;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  MyCustomFormStateGoalExpense(this._id);
  int _id;
  void _save() async {
    BudgetItem item = BudgetItem(
      name: _name,
      value: _double,
      income: 0,
    );

    await DB.insert(BudgetItem.table, item);

    List<BudgetItem> _tasks = [];

    List<Map<String, dynamic>> _results = await DB.rawQuery('SELECT * FROM budget_items WHERE budget_items.name="$_name";');
    _tasks = _results.map((item) => BudgetItem.fromMap(item)).toList();

    int _idtask = _tasks[0].id;
    print(_idtask);
    BudgetItemsList itemList = BudgetItemsList(
      budget_items_id: _idtask,
      budget_id: _id,
    );
    print(itemList.toMap());

    await DB.insert(BudgetItemsList.table, itemList);
    //make insert into budget_items_list
    prefs.setDouble('counter', _counter - _double);
    setState(() => _double = null);
    setState(() => _name = '');
    setState(() => _id = null);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add TextFormFields and RaisedButton here.
                TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                      labelText: 'Enter Name', hintText: 'Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: myControllerNumber,
                  decoration: InputDecoration(
                      labelText: 'Enter Value', hintText: 'Value'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        _name = myController.text;
                        _double = double.parse(myControllerNumber.text);
                        _save();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ])),
    );
  }
}
