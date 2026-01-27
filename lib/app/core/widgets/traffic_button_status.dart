import 'package:flutter/material.dart';

import 'traffic_button.dart';

class TrafficButtonStatus extends StatelessWidget {
  final String? status;

  const TrafficButtonStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return status == 'done'
        ? const TrafficButton(
            backgroundColor: Colors.green,
            value: 4,
            maxValue: 4,
            minValue: 0,
            division: 4)
        : status == 'not done'
            ? const TrafficButton(
                backgroundColor: Colors.red,
                value: 0,
                maxValue: 4,
                minValue: 0,
                division: 4)
            : status == 'delay done'
                ? const TrafficButton(
                    backgroundColor: Colors.yellowAccent,
                    value: 2,
                    maxValue: 4,
                    minValue: 0,
                    division: 4)
                : status == 'assigned'
                    ? const TrafficButton(
                        backgroundColor: Colors.indigo,
                        value: 1,
                        maxValue: 4,
                        minValue: 0,
                        division: 4)
                    : const TrafficButton(
                        backgroundColor: Colors.grey,
                        value: 3,
                        maxValue: 4,
                        minValue: 0,
                        division: 4);
  }
}
