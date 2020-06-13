import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reference_photo_app/helpers/enums.dart';
import 'package:reference_photo_app/views/pages/slide_page.dart';
import 'package:reference_photo_app/widgets/slide_filter.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // EXAMPLE WITH AZURE SEARCH SERVICE
  //&$filter=gender eq 'female' and clothing eq 'nude' and direction eq 'back'
  String _filterString = "&\$filter=";
  Gender currGender = Gender.all;
  Clothing currClothing = Clothing.all;
  Pose currPose = Pose.all;
  Direction currDirection = Direction.all;
  Duration _duration;

  _nextValue(var value) {
    print(value is Clothing);
    if (value is Clothing) {
      if (_validateNext(Clothing.values, currClothing.index)) {
        setState(() {
          currClothing = Clothing.values[currClothing.index + 1];
        });
      } else {
        setState(() {
          currClothing = Clothing.values[0];
        });
      }
    } else if (value is Gender) {
      if (_validateNext(Gender.values, currGender.index)) {
        setState(() {
          currGender = Gender.values[currGender.index + 1];
        });
      } else {
        setState(() {
          currGender = Gender.values[0];
        });
      }
    } else if (value is Pose) {
      if (_validateNext(Pose.values, currPose.index)) {
        setState(() {
          currPose = Pose.values[currPose.index + 1];
        });
      } else {
        setState(() {
          currPose = Pose.values[0];
        });
      }
    } else if (value is Direction) {
      if (_validateNext(Direction.values, currDirection.index)) {
        setState(() {
          currDirection = Direction.values[currDirection.index + 1];
        });
      } else {
        setState(() {
          currDirection = Direction.values[0];
        });
      }
    }

    print(value.toString());
  }

  _validateNext(List list, int index) {
    print('len: ' + list.length.toString() + ' index: ' + index.toString());
    if (list.length - 1 >= index + 1) {
      return true;
    }

    return false;
  }

  _prevValue(value) {
    if (value is Clothing) {
      if (_validatePrev(currClothing.index)) {
        setState(() {
          currClothing = Clothing.values[currClothing.index - 1];
        });
      } else {
        setState(() {
          currClothing = Clothing.values[Clothing.values.length - 1];
        });
      }
    } else if (value is Gender) {
      if (_validatePrev(currGender.index)) {
        setState(() {
          currGender = Gender.values[currGender.index - 1];
        });
      } else {
        setState(() {
          currGender = Gender.values[Gender.values.length - 1];
        });
      }
    } else if (value is Pose) {
      if (_validatePrev(currPose.index)) {
        setState(() {
          currPose = Pose.values[currPose.index - 1];
        });
      } else {
        setState(() {
          currPose = Pose.values[Pose.values.length - 1];
        });
      }
    } else if (value is Direction) {
      if (_validatePrev(currDirection.index)) {
        setState(() {
          currDirection = Direction.values[currDirection.index - 1];
        });
      } else {
        setState(() {
          currDirection = Direction.values[Direction.values.length - 1];
        });
      }
    }
  }

  _validatePrev(int index) {
    if (index - 1 >= 0) {
      return true;
    }

    return false;
  }

  _FilterPageState() {
    print("current gender: " + currGender.toString().split('.').last);
  }

  _setFilterString() {
    setState(() {
      _filterString = "&\$filter=";
      _filterString += currGender == Gender.all
          ? ''
          : "gender eq '${currGender.toString().split('.').last}' and ";
      _filterString += currClothing == Clothing.all
          ? ''
          : "clothing eq '${currClothing.toString().split('.').last}' and ";
      _filterString += currPose == Pose.all
          ? ''
          : "pose eq '${currPose.toString().split('.').last}' and ";
      _filterString += currDirection == Direction.all
          ? ''
          : "direction eq '${currDirection.toString().split('.').last}' and ";
    });

    if (_filterString == "&\$filter=") {
      setState(() {
        _filterString = "";
      });
    }
    if (_filterString != "") {
      _filterString = _filterString.substring(0, _filterString.length - 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SlideFilter(currGender, _prevValue, _nextValue),
                SlideFilter(currClothing, _prevValue, _nextValue),
                SlideFilter(currPose, _prevValue, _nextValue),
                SlideFilter(currDirection, _prevValue, _nextValue),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    onTimerDurationChanged: (value) {
                      setState(() {
                        _duration = value;
                      });
                    },
                  ),
                ),
                FlatButton(
                    color: Colors.transparent,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 3,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      width: 250,
                      height: 60,
                      child: Center(
                        child: Text(
                          'START',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _setFilterString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SlidePage(_filterString, _duration)),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
