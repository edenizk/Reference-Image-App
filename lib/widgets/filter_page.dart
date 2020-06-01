

import 'package:flutter/material.dart';
import 'package:reference_photo_app/widgets/slide_page.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Filter'),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Start'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlidePage()),
                );
              }
            )
          ],
         
        ),
      ),
 
    );
  }
}