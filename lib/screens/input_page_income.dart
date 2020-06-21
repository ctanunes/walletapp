import 'package:flutter/material.dart';
import 'package:testingflutterapp/components/input_form.dart';
import 'package:testingflutterapp/components/input_form_income.dart';

class SecondRouteIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Income"),
      ),
      body: MyCustomFormIncome(),
    );
  }
}