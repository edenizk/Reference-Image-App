import 'package:flutter/material.dart';

class SlidePage extends StatefulWidget {
  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Slides of images'),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Text('Here will be slides')
          ],
         
        ),
      ),
 
    );
  }
}