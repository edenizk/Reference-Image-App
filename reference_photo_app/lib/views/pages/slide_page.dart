import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
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
  final Duration duration;
  SlidePage(this.filterString, this.duration);

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
  // Duration _duration;
  Timer _timer;

  // EXAMPLE WITH AZURE SEARCH SERVICE
  //&$filter=gender eq 'female' and clothing eq 'nude' and direction eq 'back'
  // https://ergindenizazureblob.search.windows.net/indexes/refphotos-index/docs?api-version=2019-05-06&search=*&$filter=gender eq 'female' and clothing eq 'nude' and direction eq 'back''
  String _url =
      "https://ergindenizazureblob.search.windows.net/indexes/refphotos-index/docs?api-version=2019-05-06&search=*";

  _SlidePageState() {
    // if(widget.duration.inHours != 0 || widget.duration.inMinutes != 0 || widget.duration.inSeconds != 0){
    //   _duration = widget.duration;
    // }else{
    //   _duration = Duration(seconds: 30);
    // }
  }

  void initState() {
    super.initState();
    print('slidepage const');
    print('filter: ' + widget.filterString);
    _url += widget.filterString ?? '';
    fetchRefPhotos();
    _resetTimer();
    _startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
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

    if (refPhotos.isEmpty) {
      popupEmpty();
    }

    setIndex();
  }

  void popupEmpty() {
    showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[Text('There are no photos with this filter')],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
            ],
          );
        });
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
      if (widget.duration != null) {
        _counter = widget.duration.inSeconds;
      } else {
        _counter = 30;
      }
    });
  }

  _playPause() {
    _timer.isActive ? _timer.cancel() : _startTimer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        // color: Colors.red,
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => {Navigator.pop(context)})),
            Container(
              margin: EdgeInsets.only(top: 70),
              // color: Colors.blue,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width,
              child: refPhotos.length > 0
                  ? TransitionToImage(
                      alignment: Alignment.center,
                      image: AdvancedNetworkImage(
                          refPhotos[_currentPhotoIndex].getUrl()),
                      fit: BoxFit.cover,
                      placeholder: CircularProgressIndicator(),
                    )
                  : Loading(
                      indicator: BallSpinFadeLoaderIndicator(),
                      size: 100.0,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
            ),
            Container(
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: <Widget>[
                    SlideController(_playPause, _previousPhoto, _nextPhoto,
                        _timer.isActive),
                    SlideTimer(
                        "${(_counter / 3600).floor()}:${((_counter % 3600) / 60).floor()}:${((_counter % 3600) % 60).floor()}")
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
