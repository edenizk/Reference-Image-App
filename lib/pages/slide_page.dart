import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:reference_photo_app/class/ref_photos.dart';
import 'package:reference_photo_app/widgets/slide_controller.dart';
import 'package:reference_photo_app/widgets/slide_timer.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class SlidePage extends StatefulWidget {
  final String filterString;
  SlidePage(this.filterString);

  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  List<RefPhotos> refPhotos = new List<RefPhotos>();
  List<RefPhotos> refPhotostest = new List<RefPhotos>();

  List<int> indexTree = new List<int>();
  int _treeIndex = 0;
  int _currentPhotoIndex = 0;
  int _counter;
  int _duration = 10;
  Timer _timer;

  // EXAMPLE WITH AZURE SEARCH SERVICE
  //&$filter=gender eq 'female' and clothing eq 'nude' and direction eq 'back'
  // https://ergindenizazureblob.search.windows.net/indexes/refphotos-index/docs?api-version=2019-05-06&search=*&$filter=gender eq 'female' and clothing eq 'nude' and direction eq 'back''
  String _url =
      "https://ergindenizazureblob.search.windows.net/indexes/refphotos-index/docs?api-version=2019-05-06&search=*";

  _SlidePageState() {

  }

  void initState() {
    super.initState();
    print('filter: ' + widget.filterString);
    _url += widget.filterString ?? '';
    fetchRefPhotos();
    _resetTimer();
    _startTimer();
  }

  void fetchRefPhotos() async {
    final response = await http.get(
      _url,
      headers: {'api-key': "C14B8AE093BA597288A2905C34013079"},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> photos = jsonDecode(response.body.toString());
      photos["value"].forEach((photo) => {
            refPhotos
                .add(new RefPhotos(fileName: photo['metadata_storage_name'])),
          });
    } else {
      throw Exception(
          'Failed to load response code : ' + response.statusCode.toString());
    }

    setIndex();
  }

  void setIndex() {
    var rng = new Random();

    setState(() {
      _currentPhotoIndex =
          refPhotos.length > 0 ? rng.nextInt(refPhotos.length) : 0;
      indexTree.add(_currentPhotoIndex);
      _treeIndex++;
    });
  }

  _nextPhoto() {
    // _startTimer();
    if (indexTree.length != _treeIndex) {
      // print("tree index: "  + _treeIndex.toString() + "\nindex Tree len: " + indexTree.length.toString());
      setState(() {
        _treeIndex++;
        _currentPhotoIndex = indexTree[_treeIndex - 1];
      });
    } else {
      setIndex();
    }

    _resetTimer();
  }

  _previousPhoto() {
    if (_treeIndex > 1) {
      setState(() {
        _treeIndex--;
        _currentPhotoIndex = indexTree[_treeIndex - 1];
      });
      _resetTimer();
    }
  }

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _nextPhoto();
        }
      });
    });
  }

  _resetTimer() {
    setState(() {
      _counter = _duration;
    });
  }

  _playPause() {
    _timer.isActive ? _timer.cancel() : _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.red,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => {Navigator.pop(context)})),
            Container(
              margin: EdgeInsets.only(top: 70),
              color: Colors.blue,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width,
              child: refPhotos.length > 0
                  ? Image(
                      alignment: Alignment.center,
                      image:
                          NetworkImage(refPhotos[_currentPhotoIndex].getUrl()),
                      fit: BoxFit.cover)
                  : Loading(
                      indicator: BallSpinFadeLoaderIndicator(),
                      size: 100.0,
                      color: Colors.black),
            ),
            Container(
                // color: Colors.green,
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: <Widget>[
                    SlideController(_playPause, _previousPhoto, _nextPhoto),
                    SlideTimer(_counter)
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
