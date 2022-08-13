import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/aninmation/animation.dart';
import 'package:flutter_application_1/pages/loginpage.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  late String _email, _password, _confermpassword;

  final auth = FirebaseAuth.instance;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confermpasswordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confermpasswordcontroller.dispose();

    super.dispose();
  }

  regestration() async {
    if (_password == _confermpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailcontroller.text.trim(),
                password: _passwordcontroller.text.trim());
        print(userCredential);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "The user has been registered... please login again",
              style: TextStyle(fontSize: 20.0),
            )));

        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const loginpage())));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("password is too weak");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                "password is too weak",
                style: TextStyle(fontSize: 20.0),
              )));
        } else if (e.code == 'user-not-found') {
          print('No user found for that email.');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                "No user found for that email.",
                style: TextStyle(fontSize: 20.0),
              )));
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                "Wrong password provided for that user.",
                style: TextStyle(fontSize: 20.0),
              )));
        }
      }
    } else {
      print("password does not match");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "password does not match",
            style: TextStyle(fontSize: 20.0),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/ddd.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formkey,
            child: FadeAnimation(
                child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 90, left: 25),
                  child: const Text("SIGN UP",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: 35,
                        right: 35),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: const Text("Email"),
                                hintText: "Enter Email",
                                prefixIcon: const Icon(Icons.person)),
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter your Email";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                            controller: _passwordcontroller,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              label: const Text("Password"),
                              hintText: "Enter password",
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _password = value.trim();
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter your password";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                            controller: _confermpasswordcontroller,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              label: const Text("Conferm Password"),
                              hintText: "Enter Conferm password",
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter your Conferm password";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    _email = _emailcontroller.text;
                                    _password = _passwordcontroller.text;
                                    _confermpassword =
                                        _confermpasswordcontroller.text;
                                  });
                                  regestration();
                                }
                              },
                              child: const Text("SIGN UP")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              const Text("Already have an account"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const loginpage()));
                                  },
                                  child: const Text("LOGIN"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
