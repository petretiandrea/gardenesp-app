import 'package:flutter/material.dart';
import 'package:gardenesp/theme.dart';

Widget preview(Widget? body) {
  return MaterialApp(
    theme: GardenEspTheme.dark(),
    builder: (context, child) {
      return Scaffold(
        appBar: AppBar(),
        body: body,
      );
    },
  );
}
