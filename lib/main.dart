import 'package:flutter/material.dart';
import 'package:newtask/page1.dart';

void main() {
  runApp(const New());
}
class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Page1(),
    );
  }
}
