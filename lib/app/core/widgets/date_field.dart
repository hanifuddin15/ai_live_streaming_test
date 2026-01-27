import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrimaryDateField extends StatelessWidget {
  PrimaryDateField({super.key, required this.date});
  String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey, border: Border.all()),
      child: const Text('13 JAN 2023'),


    );
  }
}
