import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF003153),
      child: SafeArea(
        child: Scaffold(
            body: Container(
                child: ListView(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  color: Color(0xFF003153),
                  child: Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 16),
                    Text(
                      'Sign Up',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .apply(color: Colors.white),
                    )
                  ]),
                )),
          ),
          RegisterForm()
        ]))),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String city;
  final _nameController = TextEditingController();
  final _passportNoController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _nameController.text = user.displayName;
  }

  void formProcessor() async {
    /*
      Add the document of the UserDetails to the usercollection class
      For model reference, check models.dart
    */
    final database = FirebaseFirestore.instance.collection('users');
    await database.doc('${user.uid}').set({
      'name': _nameController.text,
      'uid': user.uid,
      'email': user.email,
      'city': city,
      'passportNo': int.parse(_passportNoController.text),
      'phoneNo': _phoneNoController.text,
      'address': _addressController.text,
      'type': 'resident',
      'notification': [],
      'bookmarked': [],
      'category': "general",
      'profilePic': "",
      'list of my filed Complaints': []
    });
  }

  void _showDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003153)),
          ),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("  Registering...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // Doesn't allow the dialog box to pop
        return WillPopScope(
            onWillPop: () {
              return;
            },
            child: alert);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Name cannot be left Empty';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return 'Passport Number cannot be left Empty';
                    }
                    final n = num.tryParse(value);
                    if (n == null) {
                      return '"$value" is not a valid passport number';
                    }
                    if (value.length != 12)
                      return 'Passport Number must contain 12 digits';
                    return null;
                  },
                  controller: _passportNoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Passport Number',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Container(
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        child: Text(
                          'City',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      value: city,
                      onChanged: (String newValue) {
                        setState(() {
                          city = newValue;
                        });
                      },
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      items: <String>[
                        'Ayer Itam',
                        'Balik Pulau',
                        'Batu Ferringhi',
                        'Batu Maung',
                        'Bayan Lepas',
                        'Bukit Mertajam',
                        'Butterworth',
                        'Gelugor',
                        'Jelutong',
                        'Kepala Batas',
                        'Kubang Semang',
                        'Nibong Tebal',
                        'Penang Hill',
                        'Perai',
                        'Permatang Pauh',
                        'Simpang Ampat',
                        'Sungai Jawi',
                        'Tanjong Bungah',
                        'Tasek Gelugor',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Phone Number cannot be left Empty';
                    }
                    return null;
                  },
                  controller: _phoneNoController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Address cannot be left Empty';
                    }
                    return null;
                  },
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Establishing Contact with the Server')));
                        _showDialog(context);
                        formProcessor();
                        Navigator.pop(context, '/');
                        Navigator.pop(context, '/RegisterPage');
                        Navigator.pushReplacementNamed(context, '/navigation');
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    highlightElevation: 5,
                    color: Color(0xFF003153),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 170,
                  width: 170,
                  child: Image.asset(
                    "assets/app_logo.png",
                  ),
                ),
                Text('© MyAduan',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..addArc(Rect.fromLTWH(0, 0, size.width / 2, size.width / 3), pi, -1.57)
      ..lineTo(9 * size.width / 10, size.width / 3)
      ..addArc(
          Rect.fromLTWH(
              size.width / 2, size.width / 3, size.width / 2, size.width / 3),
          pi + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 6);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}
