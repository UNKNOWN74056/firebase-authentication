import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme%20privider/changethemebutton.dart';
import 'package:flutter_application_1/theme%20privider/theme.dart';
import 'package:provider/provider.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("setting"),
      ),
    );
  }
}
