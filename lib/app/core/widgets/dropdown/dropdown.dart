// import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// import '../../extensions/context_extension.dart';
// import '../../utils/color.dart';

// const OutlineInputBorder ENABLED_BORDER = OutlineInputBorder(
//   borderSide: BorderSide(width: 1, color: ENABLED_BORDER_COLOR),
// );
// const OutlineInputBorder FOCUSED_BORDER = OutlineInputBorder(
//   borderSide: BorderSide(width: 1, color: FOCUSED_BORDER_COLOR),
// );
// const OutlineInputBorder ERROR_BORDER = OutlineInputBorder(
//   borderSide: BorderSide(width: 1, color: ERROR_BORDER_COLOR),
// );
// const OutlineInputBorder FOCUSED_ERROR_BORDER = OutlineInputBorder(
//   borderSide: BorderSide(width: 1, color: FOCUSED_ERROR_BORDER_COLOR),
// );

// class PrimaryDropDownField extends StatelessWidget {
//   const PrimaryDropDownField({
//     super.key,
//     required this.list,
//     required this.onChanged,
//     this.value,
//     this.hint,
//     this.validationText,
//     this.decoration,
//     this.hintStyle,
//     this.dropDownTextStyle,
//     this.title,
//     this.titleStyle,
//     this.dropdownMaxHeight = 250,
//     this.isRequired = false,
//   });

//   final List<dynamic> list;
//   final String? hint;
//   final String? validationText;
//   final void Function(String? value) onChanged;
//   final String? value;
//   final InputDecoration? decoration;
//   final TextStyle? hintStyle;
//   final TextStyle? dropDownTextStyle;

//   /// 🏷️ Optional title above the dropdown
//   final String? title;
//   final TextStyle? titleStyle;

//   /// 📏 Optional dropdown max height
//   final double dropdownMaxHeight;

//   /// ❗ Whether the field is required (adds a red asterisk)
//   final bool isRequired;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final colorScheme = Theme.of(context).colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null) ...[
//           RichText(
//             text: TextSpan(
//               text: title!,
//               style:
//                   titleStyle ??
//                   textTheme.labelLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: colorScheme.onSurface,
//                   ),
//               children: [
//                 if (isRequired)
//                   const TextSpan(
//                     text: ' *',
//                     style: TextStyle(color: Colors.red),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 6),
//         ],
//         DropdownButtonFormField2<String>(
//           value: (value == '') ? null : value,
//           isExpanded: true,
//           decoration: decoration,
//           hint: Text(hint ?? '', style: hintStyle),
//           items:
//               list
//                   .map(
//                     (e) => DropdownMenuItem<String>(
//                       value: e,
//                       child: Text('$e', style: dropDownTextStyle),
//                     ),
//                   )
//                   .toList(),
//           onChanged: onChanged,
//           validator: (val) {
//             if (isRequired && (val ?? '').isEmpty) {
//               return validationText ?? 'This field is required';
//             }
//             return null;
//           },
//           dropdownStyleData: DropdownStyleData(
//             maxHeight: dropdownMaxHeight,
//             offset: const Offset(0, -4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: colorScheme.surface,
//               boxShadow: const [
//                 BoxShadow(
//                   blurRadius: 8,
//                   color: Colors.black12,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SecondaryDropDownField extends StatelessWidget {
//   const SecondaryDropDownField({
//     super.key,
//     required this.list,
//     required this.selectedItem,
//     this.validationText,
//     this.hint,
//     required this.onChanged,
//   });

//   final List<Object> list;
//   final Object? selectedItem;
//   final String? hint;
//   final String? validationText;
//   final void Function(Object? value)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<Object>(
//       value: selectedItem,
//       hint: Text(hint ?? '', style: const TextStyle(fontSize: 16)),
//       items:
//           list
//               .map(
//                 (e) => DropdownMenuItem<Object>(
//                   value: e,
//                   child: Text(
//                     '$e',
//                     style: context.themeData.textTheme.labelSmall,
//                   ),
//                 ),
//               )
//               .toList(),
//       onChanged: onChanged,
//       // !!!: The decoration is commented to match Inputdecoration Theme

//       // decoration:Theme.of(context).inputDecorationTheme
//       // //  const InputDecoration(
//       // //   fillColor: Colors.white,
//       // //   filled: true,
//       // //   contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
//       // //   enabledBorder: ENABLED_BORDER,
//       // //   focusedBorder: FOCUSED_BORDER,
//       // //   errorBorder: ERROR_BORDER,
//       // //   focusedErrorBorder: FOCUSED_ERROR_BORDER,
//       // // ),
//       validator: (value) {
//         if (value == null) {
//           return validationText;
//         } else {
//           return null;
//         }
//       },
//     );
//   }
// }
