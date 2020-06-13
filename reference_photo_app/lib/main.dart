import 'dart:convert';
import 'dart:typed_data';

import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';
import 'package:reference_photo_app/class/ref_photos.dart';
import 'package:http/http.dart' as http;
import 'package:reference_photo_app/views/pages/chat_page.dart';
import 'package:reference_photo_app/views/pages/filter_page.dart';
import 'package:xml/xml.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reference Photo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         brightness: Brightness.light,
        primarySwatch: Colors.grey,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Reference Photo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  var myImage;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage()),
              )
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 3, color: Theme.of(context).brightness == Brightness.dark ? Colors.white :Colors.black),
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  width: 260,
                  height: 160,
                  child: Text(
                    'Get Start',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
