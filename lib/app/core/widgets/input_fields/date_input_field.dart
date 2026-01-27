// import '../../extensions/context_extension.dart';
// import 'text_form_field.dart';
// import 'package:flutter/material.dart';

// class DateInputField extends StatelessWidget {
//   final String hint;
//   final TextEditingController controller;

//   const DateInputField({
//     super.key,
//     required this.hint,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: PrimaryTextFormField(
//         controller: controller,
//         textStyle: const TextStyle(fontSize: 13),
//         readOnly: true,
//         onTap: () async {
//           final selectedDate = await showDatePickerDialog(context: context);
//           if (selectedDate != null) {
//             controller.text =
//                 '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
//           }
//         },
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: context.colorScheme.outlineVariant,
//           prefixIcon: Icon(
//             Icons.calendar_month,
//             color: context.colorScheme.primary,
//             size: 20,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: context.colorScheme.outlineVariant,
//               width: 2,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: context.colorScheme.outlineVariant,
//               width: 2,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: context.colorScheme.outlineVariant,
//               width: 1.2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
