import 'package:flutter/material.dart';
import 'package:flutter_application_1/getdata/getdata.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return const getdata();
  }
}
