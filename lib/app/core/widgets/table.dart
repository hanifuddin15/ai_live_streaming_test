// import 'package:flutter/material.dart';

// import '../models/table_header.dart';

// class PrimaryTable extends StatelessWidget {
//   const PrimaryTable(
//       {super.key,
//       required this.header,
//       required this.tableRows,
//       this.headerBackgroundColor});

//   final TableHeader header;
//   final List<TableRow> tableRows;
//   final Color? headerBackgroundColor;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Table(
//           border: TableBorder.all(),
//           // columnWidths: const {
//           //   0: FlexColumnWidth(4),
//           //   1: FlexColumnWidth(4),
//           //   2: FlexColumnWidth(4),
//           //   3: FlexColumnWidth(4),
//           // },
//           children: [
//             TableRow(
//                 children: header.columnNames
//                     .map((headerText) => Container(
//                           height: header.columnHeight,
//                           color: header.backgroundColor,
//                           child: Center(
//                             child: Text(
//                               headerText,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ))
//                     .toList())
//           ],
//         ),
//         Table(
//             border: TableBorder.all(),
//             columnWidths: const {
//               0: FlexColumnWidth(4),
//               1: FlexColumnWidth(4),
//               2: FlexColumnWidth(4),
//               3: FlexColumnWidth(4),
//             },
//             children: tableRows)
//       ],
//     );
//   }
// }
