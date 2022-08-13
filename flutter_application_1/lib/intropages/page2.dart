import 'package:flutter/material.dart';

class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 130, 228, 231),
      child: const Center(child: Text("page2")),
    );
  }
}
