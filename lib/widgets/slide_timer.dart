import 'package:flutter/material.dart';

class SlideTimer extends StatefulWidget {
  final int counter;
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
        widget.counter.toString(),
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
