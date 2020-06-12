import 'package:flutter/material.dart';

class SlideFilter extends StatefulWidget {
  final value;
  final Function prevValue;
  final Function nextValue;
  const SlideFilter(this.value, this.prevValue, this.nextValue);

  @override
  _SlideFilterState createState() => _SlideFilterState();
}

class _SlideFilterState extends State<SlideFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                widget.prevValue(widget.value);
              }),
          Text(widget.value.toString().split('.').last),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                widget.nextValue(widget.value);
              }),
        ],
      ),
    );
  }
}
