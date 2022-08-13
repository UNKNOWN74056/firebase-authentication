import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotpasswordpage extends StatefulWidget {
  const forgotpasswordpage({Key? key}) : super(key: key);

  @override
  State<forgotpasswordpage> createState() => _forgotpasswordpageState();
}

class _forgotpasswordpageState extends State<forgotpasswordpage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  late String _email;
  final _emailcontroller = TextEditingController();
  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Rsetpassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Reset email has been send to user?",
            style: TextStyle(fontSize: 20.0),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orange,
            content: Text(
              "No user found",
              style: TextStyle(fontSize: 20.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            decoration: InputDecoration(
                label: const Text("Email"),
                hintText: "Enter your email",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          const SizedBox(width: double.infinity, height: 20),
          ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    _email = _emailcontroller.text;
                  });
                  Rsetpassword();
                }
              },
              child: const Text("Send Email"))
        ],
      ),
    );
  }
}
