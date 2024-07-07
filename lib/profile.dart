import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signing/provider/content_Provider.dart';
import 'package:signing/storage/data_store.dart';
import 'Login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _dName;
  late String _email;
  String? _name;
  String? _phone;
  bool _isLoading = false;
  final naCtl = TextEditingController();
  final phCtl = TextEditingController();
  Uint8List? _image;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void saveData() async {
    String name = naCtl.text;
    String mobile = phCtl.text;

    String res = await StoreData().save(name: name, mobile: mobile);
  }

  void update() async {
    String name = naCtl.text;
    String mobile = phCtl.text;

    String res = await StoreData().update(name: name, mobile: mobile);
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      _dName = firebaseUser.displayName!;
      _email = firebaseUser.email!;
      final DocumentSnapshot data = await FirebaseFirestore.instance
          .collection("userProfile")
          .doc(_dName)
          .collection('userInfo')
          .doc(_email)
          .get();
      if (data == null) {
        return;
      } else {
        _name = data.get('name');
        _phone = data.get('mobile');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    // print(_name);
    // print(_phone);
    // try {
    //
    //   final DocumentSnapshot userDoc =
    //       await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    //
    // } catch (error) {
    //
    // }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select image from:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text('Camera'),
          ),
        ],
      ),
    );

    if (pickedImage != null) {
      final pickedFile = await picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        final bytes = await File(pickedFile.path).readAsBytes();
        setState(() {
          _image = bytes;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  final GoogleSignIn _googleSignIn = new GoogleSignIn();
                  _googleSignIn.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: _isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 70),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).iconTheme.color,
                              radius: 80,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).iconTheme.color,
                                radius: 80,
                                backgroundImage: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToiRnzzyrDtkmRzlAvPPbh77E-Mvsk3brlxQ&s",
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 10,
                        right: -10,
                        child: IconButton(
                          onPressed: _selectImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                        child: Text(
                            // snapshot.data!.get(['name'])
                            //data['name']
                            // getData()
                            _name == null
                                ? context.watch<ChangeProfile>().editName
                                : _name!
                            //context.watch<ChangeProfile>().editName
                            ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                        child: Text(
                            //context.watch<ChangeProfile>().editMobile
                            //data['mobile']
                            _phone == null
                                ? context.watch<ChangeProfile>().editMobile
                                : _phone!
                            // snapshot.data!.get(['mobile'])
                            ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextFormField(
                    controller: naCtl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: Text("Name"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextFormField(
                    controller: phCtl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      label: Text("Phone Number"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12),
                    onPressed: () async {
                      saveData();
                      context.read<ChangeProfile>().changeDetails(
                          editedName: naCtl.text, editedMobile: phCtl.text);
                      naCtl.clear();
                      phCtl.clear();
                    },
                    child: const Text(
                      "Save Data",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      saveData();
                    },
                    child: Text('sim'))
              ],
            ),
    );
  }
}
