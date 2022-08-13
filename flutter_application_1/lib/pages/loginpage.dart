import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/aninmation/animation.dart';
import 'package:flutter_application_1/pages/forgotpasswordpage.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  late String _email, _password;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim());

      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const home())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orange,
            content: Text(
              "No user found",
              style: TextStyle(fontSize: 20.0),
            )));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orange,
            content: Text(
              "Wrong password provided for the user.",
              style: TextStyle(fontSize: 20.0),
            )));
      }
    }
  }

  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }

      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const home())));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/ddd.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formkey,
            child: Stack(
              children: [
                FadeAnimation(
                    child: Container(
                  padding: const EdgeInsets.only(top: 120, left: 25),
                  child: const Text("WELCOME\n BACK",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                )),
                FadeAnimation(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4,
                          left: 35,
                          right: 35),
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                label: const Text("Username"),
                                hintText: "Enter username",
                                prefixIcon: const Icon(Icons.person)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter your username";
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
                                  borderRadius: BorderRadius.circular(25)),
                              label: const Text("Password"),
                              hintText: "Enter password",
                              prefixIcon: const Icon(Icons.lock),
                            ),
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    _email = _emailcontroller.text;
                                    _password = _passwordcontroller.text;
                                  });
                                  login();
                                }
                              },
                              child: const Text("LOG IN")),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Container(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const forgotpasswordpage()));
                                      },
                                      child: const Text(
                                        "Forgot password",
                                        style: TextStyle(fontSize: 15),
                                      )),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const signup()));
                                    },
                                    child: const Text(
                                      "SIGN UP",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                TextButton(
                                    onPressed: googleLogin,
                                    child: const Text(
                                      "Google",
                                      style: TextStyle(fontSize: 15),
                                    ))
                              ],
                            )),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
