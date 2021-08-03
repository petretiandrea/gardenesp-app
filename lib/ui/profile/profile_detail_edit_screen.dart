import 'package:flutter/material.dart';

class ProfileDetailEditScreen extends StatelessWidget {
  ProfileDetailEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SafeArea(
        child: Text("ciao"),
      ),
    );
  }
}
