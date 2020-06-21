import 'package:flutter/material.dart';
import 'package:testingflutterapp/components/input_form.dart';
import 'package:testingflutterapp/components/input_form_goal.dart';
import 'package:testingflutterapp/components/input_form_income.dart';

class SecondRouteGoal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup a Goal"),
      ),
      body: MyCustomFormGoal(),
    );
  }
}