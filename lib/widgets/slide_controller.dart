import 'package:flutter/material.dart';

class SlideController extends StatefulWidget {
  final Function playPause;
  final Function previousPhoto;
  final Function nextPhoto;
  SlideController(this.playPause, this.previousPhoto, this.nextPhoto);

  @override
  _SlideControllerState createState() => _SlideControllerState();
}

class _SlideControllerState extends State<SlideController> {
  bool _isActive = true;

  _SlideControllerState(){
    // _isActive = widget.isTimerActive != null ? widget.isTimerActive : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20),
              color: Colors.red,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 60,
                  ),
                  onPressed: () => {widget.previousPhoto()})),
          Container(
              child: IconButton(
                  icon: Icon(
                    _isActive ? Icons.pause : Icons.play_arrow,
                    size: 60,
                    color: Colors.black,
                  ),
                  onPressed: () => {
                    
                    widget.playPause()})),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 60,
                  ),
                  onPressed: () => {widget.nextPhoto()}))
        ],
      ),
    );
  }
}
