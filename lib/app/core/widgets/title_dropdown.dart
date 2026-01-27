import 'package:flutter/material.dart';

class TitleDropDown extends StatelessWidget {
  final List<String> list;
  final String title;
  final String hints;
  final double dropdownWidth;
  final double dropdownHeight;

  const TitleDropDown(
      {super.key,
      required this.list,
      required this.title,
      required this.hints,
      required this.dropdownWidth,
      required this.dropdownHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(
          width: dropdownWidth,
          height: dropdownHeight,
          child: DropdownButtonFormField<String>(
            hint: Text(hints),
            items: list
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            validator: (value) {
              return null;

              // if ((value ?? '').isEmpty) {
              //   return validationText;
              // } else {
              //   return null;
              // }
            },
          ),
        ),
      ],
    );
  }
}
