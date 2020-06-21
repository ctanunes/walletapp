import 'package:flutter/material.dart';
import 'package:testingflutterapp/components/input_form.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a expense"),
      ),
      body: MyCustomForm(),
    );
  }
}