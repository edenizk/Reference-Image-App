

import 'package:flutter/material.dart';
import 'package:reference_photo_app/helpers/enums.dart';
import 'package:reference_photo_app/pages/slide_page.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // EXAMPLE WITH AZURE SEARCH SERVICE
  //&$filter=gender eq 'female' and clothing eq 'nude' and direction eq 'back'
  String filterString = "&\$filter=";
  Gender currGender = Gender.all;
  Clothing currClothing;
  Pose currPose;
  Direction currDirection;
  
  _FilterPageState(){
    // currGender = Gender.all;
    // currClothing = Clothing.all;
    // currPose = Pose.all;
    // currDirection = Direction.all;
    print("current gender: " + currGender.toString().split('.').last);
  }

  _setFilterString(){
    setState(() {
      filterString += currGender == Gender.all ? '' : "gender eq '${currGender.toString().split('.').last}'";
      filterString += currClothing == Clothing.all ? '' : "clothing eq '${currClothing.toString().split('.').last}'";
      filterString += currPose == Pose.all ? '' : "pose eq '${currPose.toString().split('.').last}'";
      filterString += currDirection == Direction.all ? '' : "direction eq '${currDirection.toString().split('.').last}'";
    });
  }

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
                print('test');
                _setFilterString();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlidePage(filterString)),
                );
              }
            )
          ],
         
        ),
      ),
 
    );
  }
}