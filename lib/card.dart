import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loading.dart';

var user = FirebaseAuth.instance.currentUser;

class Category {
  String name;
  IconData iconName;
  String text;

  Category({this.name, this.iconName, this.text});
}

List<Category> categories = [
  Category(name: 'Phone no.', iconName: Icons.person_pin, text: '601'),
  Category(name: 'City', iconName: Icons.location_on, text: 'Penang'),
  Category(name: 'address', iconName: Icons.location_on, text: 'Address'),
];

final List<String> hostels = [
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
  'Tasek Gelugor'
];

class CardCategory extends StatefulWidget {
  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  Future<void> editList1(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit '),
                  Text(categories[0].name),
                ],
              ),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: customController,
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .update(
                              {'phoneNo': customController.text.toString()});
                    });

                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                ),
              ]);
        });
  }

  Future<void> editList2(BuildContext context, String city) {
    return showDialog(
        context: context,
        builder: (context) {
          return EditCity(city: city);
        });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
          switch (user.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.done:
              if (user.hasError) return Text('Error: ${user.error}');
              var city = user.data['city'];
              return Column(
                children: [
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: query.size.width / 14,
                        vertical: query.size.height / 80),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[0].name,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(categories[0].iconName),
                                  SizedBox(width: 5.0),
                                  Text(user.data['phoneNo'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Roboto',
                                      )),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                editList1(context);
                              },
                              icon: Icon(Icons.edit, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: query.size.width / 14,
                        vertical: query.size.height / 80),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[1].name,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(categories[1].iconName),
                                  SizedBox(width: 5.0),
                                  Text(user.data['city'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Roboto',
                                      )),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                editList2(context, user.data['city'])
                                    .then((value) => setState(() {}));
                              },
                              icon: Icon(Icons.edit, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
          return null;
        });
  }
}

class EditCity extends StatefulWidget {
  String city;
  EditCity({Key key, @required this.city}) : super(key: key);
  @override
  _EditCityState createState() => _EditCityState(city);
}

class _EditCityState extends State<EditCity> {
  String city;
  _EditCityState(this.city);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: [
            Text('Edit '),
            Text(categories[1].name),
          ],
        ),
        content: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: hostels
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: city,
                            onChanged: (value) {
                              if (value != city) {
                                setState(() {
                                  city = value;
                                });
                              }
                            },
                            selected: city == e,
                          ))
                      .toList(),
                ))),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({'city': city});

              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: Text('Save'),
          )
        ]);
  }
}
