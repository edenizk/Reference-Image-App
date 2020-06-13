import 'package:flutter/material.dart';

class SlideController extends StatefulWidget {
  final Function playPause;
  final Function previousPhoto;
  final Function nextPhoto;
  final isTimerActive;
  SlideController(
      this.playPause, this.previousPhoto, this.nextPhoto, this.isTimerActive);

  @override
  _SlideControllerState createState() => _SlideControllerState();
}

class _SlideControllerState extends State<SlideController> {
  _SlideControllerState() {
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
              padding: EdgeInsets.all(15),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 60,
                  ),
                  onPressed: () => {widget.previousPhoto()})),
          Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: IconButton(
                  icon: Icon(
                    widget.isTimerActive ? Icons.pause : Icons.play_arrow,
                    size: 60,
                  ),
                  onPressed: () => {widget.playPause()})),
          Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.all(15),
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
