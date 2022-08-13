import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme%20privider/theme.dart';
import 'package:flutter_application_1/theme%20privider/theme.dart';
import 'package:provider/provider.dart';

class changethemebutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<Themeprovider>(context);
    return Switch.adaptive(
        value: themeprovider.isDarkMode,
        onChanged: ((value) {
          final provider = Provider.of<Themeprovider>(context, listen: false);
          provider.toggletheme(value);
        }));
  }
}
