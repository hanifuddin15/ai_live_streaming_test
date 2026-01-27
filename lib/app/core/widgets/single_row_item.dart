import 'package:flutter/material.dart';

class SingleRowItem extends StatelessWidget {
  const SingleRowItem({
    super.key,
    required this.title,
    this.value,
    this.titleTextStyle,
    this.valueTextStyle,
  });
  final String title;
  final String? value;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(title, style: titleTextStyle)),
        const Text(': '),
        Expanded(
            child: Text(
          value ?? '',
          style: valueTextStyle,
          textAlign: TextAlign.end,
        )),
      ],
    );
  }
}

class RequisitionSingleRowItem extends StatelessWidget {
  const RequisitionSingleRowItem({
    super.key,
    required this.title,
    this.value,
    this.titleTextStyle,
    this.valueTextStyle,
  });
  final String title;
  final String? value;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(title, style: titleTextStyle)),
        const Text(':  '),
        Expanded(
            child: Text(
          (value ?? '').trim(),
          style: valueTextStyle,
          textAlign: TextAlign.start,
        )),
      ],
    );
  }
}
