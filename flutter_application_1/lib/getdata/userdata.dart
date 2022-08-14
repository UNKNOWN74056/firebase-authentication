import 'package:flutter/material.dart';
import 'package:flutter_application_1/getdata/user.dart';

class userdata extends StatelessWidget {
  final User user;

  const userdata({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Center(
        child: Column(children: [
          Image.network(
            user.urlAvatar,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text(
            user.username,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
