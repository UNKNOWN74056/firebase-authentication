import 'package:flutter/material.dart';

class page3 extends StatefulWidget {
  const page3({Key? key}) : super(key: key);

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 155, 154, 226),
      child: const Center(child: Text("page3")),
    );
  }
}
