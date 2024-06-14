import 'Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp pattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text('Sign Up'),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailCtrl,
                    validator: validateEmail,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9))),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: passCtrl,
                    validator: validatePassword,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9))),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            UserCredential userCred = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: emailCtrl.text,
                                    password: passCtrl.text);
                            User? user = userCred.user;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Text(
                    'Already Have Ac',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !email.contains(pattern)) {
      return 'Email Id Not Valid';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password Not Valid';
    }
    return null;
  }
}
