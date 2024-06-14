import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:signing/provider/content_Provider.dart';

import 'Login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome'),
              SizedBox(
                height: 20,
              ),
              Text(context.watch<ShareProfife>().profileName),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signOut();
                        final GoogleSignIn _googleSignIn = new GoogleSignIn();
                        _googleSignIn.signOut();
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
                    'LogOut',
                    style: TextStyle(color: Colors.white),
                  )),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              //     onPressed: () async {
              //       if (_formKey.currentState!.validate()) {
              //         try {
              //           final GoogleSignIn _googleSignIn = new GoogleSignIn();
              //           _googleSignIn.signOut();
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const Login()),
              //           );
              //         } catch (e) {
              //           print(e);
              //         }
              //       }
              //     },
              //     child: Text(
              //       'SignOut',
              //       style: TextStyle(color: Colors.white),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
