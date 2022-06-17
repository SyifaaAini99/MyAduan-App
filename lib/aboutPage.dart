import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003153),
          title: Text(
            'About',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(30),
            child: ListView(children: [
              Text('What is My Aduan Mobile App?',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 10,
              ),
              Text(
                'My Aduan app is a game-changer for the user because it makes it easier for them to convey their concerns to their city administration. Using this platform, residents and local authorities can utilise technology to communicate more efficiently. As a result of considering all stakeholders (citizens), the local council will be able to make a decision based on the requirements of the community as opposed to a massive project with minimal impact. This will result in an enhanced local environment. Expanding involvement and optimising processes are only two of the advantages that users can anticipate from the application. The software is utilised by administrators, citizens (particularly from large cities), and elected authorities.',
              ),
              SizedBox(
                height: 20,
              ),
              Text('Legal Licenses',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 10,
              ),
              Text('This project is licensed under the Apache-2.0 License.'),
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
                ],
              ),
            ])));
  }
}
