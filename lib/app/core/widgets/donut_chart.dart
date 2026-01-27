// import '../extensions/context_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../modules/home/models/attendance_chart.dart';

// class DonutChart extends StatelessWidget {
//   final List<AttendanceChartModel> ChartModel;
//   final double height;
//   final double width;
//   final double innerRedious;
//   final double outerRedious;

//   const DonutChart({
//     super.key,
//     required this.ChartModel,
//     required this.height,
//     required this.width,
//     required this.innerRedious,
//     required this.outerRedious,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: SfCircularChart(
//         margin: EdgeInsets.zero,
//         tooltipBehavior: TooltipBehavior(enable: true),
//         series: <CircularSeries>[
//           DoughnutSeries<AttendanceChartModel, String>(
//             enableTooltip: true,
//             radius: '$outerRedious',
//             innerRadius: '$innerRedious',
//             dataSource: ChartModel,
//             pointColorMapper: (AttendanceChartModel data, _) => data.color,
//             xValueMapper: (AttendanceChartModel data, _) => data.title,
//             yValueMapper: (AttendanceChartModel data, _) => data.percentage,
//             dataLabelSettings: DataLabelSettings(
//               isVisible: true,
//               labelPosition: ChartDataLabelPosition.outside,
//               textStyle: context.themeData.textTheme.bodySmall?.copyWith(
//                 color: Colors.black,
//                 fontSize: 10,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             dataLabelMapper:
//                 (AttendanceChartModel data, index) =>
//                     '${data.percentage.toInt()}%',
//           ),
//         ],
//       ),
//     );
//   }
// }
