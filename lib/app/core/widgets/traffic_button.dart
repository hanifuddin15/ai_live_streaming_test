import 'package:flutter/material.dart';

class TrafficButton extends StatelessWidget {
  final Color backgroundColor;
  final double value;
  final double maxValue;
  final double minValue;
  final int division;

  const TrafficButton(
      {super.key,
      required this.backgroundColor,
      required this.value,
      required this.maxValue,
      required this.minValue,
      required this.division});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // margin: EdgeInsets.zero,
      // padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(15)),
      height: 25,
      width: 70,
      child: Slider(
        thumbColor: Colors.white,
        activeColor: backgroundColor,
        inactiveColor: backgroundColor,
        value: 0,
        max: maxValue,
        min: minValue,
        divisions: division,
        //label: _currentSliderValue.round().toString(),
        onChanged: (double value) {},
      ),
    );
  }
}
