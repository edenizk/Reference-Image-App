import 'package:credentials_helper/credentials_helper.dart';
import 'package:flutter/material.dart';
import 'package:reference_photo_app/widgets/filter_page.dart';
import 'package:azblob/azblob.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reference Photo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Reference Photo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Credentials credentials = Credentials.fromFile('config.json');

  _MyHomePageState(){
  
  }

  void _test () {
    var storage = AzureStorage.parse(credentials.apiKey);

    // await storage.putBlob('/yourcontainer/yourfile.txt',
    //   body: 'Hello, world.');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                    border: Border.all(width: 3, color: Colors.black),
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
