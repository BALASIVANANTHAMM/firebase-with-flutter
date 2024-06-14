import 'package:provider/provider.dart';
import 'package:signing/provider/content_Provider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bottom.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  RegExp pattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final mobileCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text('Login'),
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
                  child: TextFormField(
                    controller: mobileCtl,
                    validator: validateMobile,
                    decoration: InputDecoration(
                        hintText: 'Mobile',
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
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: emailCtrl.text,
                              password: passCtrl.text,
                            );
                            User? user = userCredential.user;
                            context.read<ShareProfife>().changeName(
                                newName: emailCtrl.text,
                                newMobile: mobileCtl.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Bottom()),
                            );
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: Text(
                    "Don't have Ac",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 13,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      try {
                        final GoogleSignInAccount? googleSIA = await GoogleSignIn(
                                clientId:
                                    "15561357275-d00p1m76ek2pi2bqn53c4vqne3t5hgfp.apps.googleusercontent.com")
                            .signIn();
                        final GoogleSignInAuthentication googleSiAuth =
                            await googleSIA!.authentication;
                        final AuthCredential credential =
                            GoogleAuthProvider.credential(
                                accessToken: googleSiAuth.accessToken,
                                idToken: googleSiAuth.idToken);
                        await auth.signInWithCredential(credential);
                        print(googleSIA);
                        context.read<ShareProfife>().changeName(
                            newName: await googleSIA.displayName!.toString(),
                            newMobile: mobileCtl.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Bottom()),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Sign In With Google',
                      style: TextStyle(color: Colors.white),
                    )),
              )
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

  String? validateMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty || mobile.length == 10) {
      return 'Mobile No Not Valid';
    }
    return null;
  }
}
