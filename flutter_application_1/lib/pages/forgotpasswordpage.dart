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
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/dw.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 120, left: 25),
                  child: const Text(
                    "Forgot \npassword",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: 35,
                      right: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: const Text("Email"),
                              hintText: "Enter your email",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: double.infinity, height: 20),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: 120,
                      right: 35),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            _email = _emailcontroller.text;
                          });
                          Rsetpassword();
                        }
                      },
                      child: const Text("Send Email")),
                )
              ],
            ),
          ),
        ));
  }
}
