import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/src/screens/home.dart';
import 'package:flutter_dev/src/screens/signup.dart';

class Signin extends StatefulWidget {
  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  final _auth = FirebaseAuth.instance;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                'Sign In',
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.yellow,
            ),
            body: ListView(padding: EdgeInsets.all(20.0), children: [
              Form(
                  key: _formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.mail),
                            hintText: 'Enter Your Email',
                            labelText: 'Email',
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please a valid Email';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _emailcontroller.text = value;
                          },
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.security),
                            hintText: 'Enter You Password',
                            labelText: 'Password',
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please a Enter Password';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email: _emailcontroller.text,
                                      password: _passwordcontroller.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                  return;
                                }
                              } else {
                                print("UnSuccessfull");
                              }
                            }),
                        SizedBox(
                          height: 70,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'new user? register ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()),
                                      );
                                    },
                                  style: TextStyle(
                                    color: Colors.blue,
                                  )),
                              TextSpan(text: 'text!'),
                            ],
                          ),
                        )
                      ]))
            ])));
  }
}
