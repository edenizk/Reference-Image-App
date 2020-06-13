import 'package:flutter/material.dart';

class SlideTimer extends StatefulWidget {
  final String counter;
  // final Function() startTimer;
  SlideTimer(this.counter);
  @override
  _SlideTimerState createState() => _SlideTimerState();
}

class _SlideTimerState extends State<SlideTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Text(
        widget.counter,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
