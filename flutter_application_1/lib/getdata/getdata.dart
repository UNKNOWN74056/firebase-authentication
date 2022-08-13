import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

class getdata extends StatefulWidget {
  const getdata({Key? key}) : super(key: key);

  @override
  State<getdata> createState() => _getdataState();
}

class _getdataState extends State<getdata> {
  Future<List<User>> usersFuture = getuser();

  static Future<List<User>> getuser() async {
    const url =
        'https://raw.githubusercontent.com/JohannesMilke/futurebuilder_example/master/assets/users.json';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DATA page"),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
            future: usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text("There was server issue!");
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return builduser(users);
              } else {
                return const Text("No user found");
              }
            }),
      ),
    );
  }

  @override
  Widget builduser(List<User> users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: ((context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.urlAvatar),
            ),
            title: Text(user.username),
            subtitle: Text(user.email),
          ),
        );
      }));
}
