import 'package:flutter/material.dart';
import 'package:testingflutterapp/components/input_form.dart';
import 'package:testingflutterapp/components/input_form_goal_expense.dart';

class SecondRouteGoalExpense extends StatelessWidget {
  SecondRouteGoalExpense(this.id);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a expense to this goal"),
      ),
      body: MyCustomFormGoalExpense(this.id),
    );
  }
}