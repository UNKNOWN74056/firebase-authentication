import 'package:flutter/material.dart';

class page1 extends StatefulWidget {
  const page1({Key? key}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 221, 104, 143),
      child: const Center(child: Text("page1")),
    );
  }
}
