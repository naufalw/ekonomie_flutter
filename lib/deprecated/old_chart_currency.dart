// import 'package:bezier_chart/bezier_chart.dart';
// import 'package:dio/dio.dart';
// import 'package:ekonomie/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screen_util.dart';
// import 'package:jiffy/jiffy.dart';

// class CurrencyChartData {
//   Future<List<DataPoint>> getChartData() async {
//     Dio dio = new Dio();
//     String fromCurrency = "USD";
//     String toCurrency = "IDR";
//     String symbolnya = "?symbols=$toCurrency&base=$fromCurrency";
//     String url = "https://api.exchangerate.host/";
//     // var dmin1 = Jiffy().subtract(days: 1).toString().split(" ")[0];
//     // var hargadmin1 = await dio.get("$url$dmin1$symbolnya");
//     List<DataPoint> dataChart = new List();
//     for (var i = 1; i <= 5; i++) {
//       DateTime dminDT = Jiffy().subtract(days: i);
//       var dmin = Jiffy().subtract(days: i).toString().split(" ")[0];
//       var hargadmin = await dio.get("$url$dmin$symbolnya");
//       var dataCurrency = hargadmin.data["rates"][toCurrency];
//       dataChart.add(
//         DataPoint<DateTime>(value: dataCurrency.roundToDouble(), xAxis: dminDT),
//       );
//     }
//     // print(hargadmin1.data["rates"][toCurrency].round());
//     // int num = 1;
//     return dataChart;
//   }

//   Widget currencyChartDashboard(List data) {
//     final fromDate = Jiffy().subtract(days: 5);
//     final selectedDate = Jiffy().subtract(days: 1);

//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//           color: kSecondaryColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(ScreenUtil().setSp(45.0)),
//             topRight: Radius.circular(ScreenUtil().setSp(45.0)),
//           ),
//         ),
//         child: BezierChart(
//           fromDate: fromDate,
//           toDate: selectedDate,
//           bezierChartScale: BezierChartScale.WEEKLY,
//           selectedDate: selectedDate,
//           series: [
//             BezierLine(
//               data: data,
//             )
//           ],
//           config: BezierChartConfig(
//             showDataPoints: true,
//             stepsYAxis: 1,
//             startYAxisFromNonZeroValue: true,
//             updatePositionOnTap: true,
//             displayLinesXAxis: true,
//             showVerticalIndicator: true,
//             verticalIndicatorColor: kBottomBGColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
