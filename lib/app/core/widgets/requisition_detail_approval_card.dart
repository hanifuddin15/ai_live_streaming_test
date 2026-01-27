import 'package:flutter/material.dart';

class RequisitionDetailApprovalCard extends StatelessWidget {
  final String title;
  final String name;
  final String designetion;

  const RequisitionDetailApprovalCard(
      {super.key,
      required this.title,
      required this.name,
      required this.designetion});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Text(title),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
            child: Text('$name\n$designetion'),
          ),
        ],
      ),
    );
  }
}
