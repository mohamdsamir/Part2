import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/src/screens/home.dart';
import 'package:flutter_dev/src/screens/signin.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                'Register',
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
                              return 'Please a Enter';
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
                        TextFormField(
                          controller: _confirmcontroller,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.security_sharp),
                            hintText: 'Confirm Password',
                            labelText: 'Confirm',
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please re-enter password';
                            }
                            print(_passwordcontroller.text);

                            print(_confirmcontroller.text);

                            if (_passwordcontroller.text !=
                                _confirmcontroller.text) {
                              return "Password does not match";
                            }

                            return null;
                          },
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                try {
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _emailcontroller.text,
                                      password: _passwordcontroller.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  print(e.toString());
                                }

                                return;
                              } else {
                                print("UnSuccessfull");
                              }
                            }),
                        SizedBox(
                          height: 80,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'have an account? Sign in ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signin()),
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
