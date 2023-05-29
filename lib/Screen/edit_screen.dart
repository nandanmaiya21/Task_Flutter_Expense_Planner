import 'package:flutter/material.dart';
import 'package:planner_app/widgets/edit_list.dart';

class EditScreen extends StatefulWidget {
  static const routeName = "/edit-screen";
  const EditScreen({Key key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Transactions'),
        ),
        body: EditList(),
      ),
    );
  }
}
