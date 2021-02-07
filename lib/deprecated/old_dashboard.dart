// import 'package:bezier_chart/bezier_chart.dart';
// import 'package:ekonomie/deprecated/old_chart_currency.dart';
// import 'package:ekonomie/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DashboardPage extends StatefulWidget {
//   @override
//   _DasbBoardPageState createState() => _DasbBoardPageState();
// }

// class _DasbBoardPageState extends State<DashboardPage> {
//   var index = 0;
//   List<DataPoint> dataChart;
//   CurrencyChartData _currencyChartData = new CurrencyChartData();

//   void getChhhart() async {
//     print(dataChart);
//     dataChart = await _currencyChartData.getChartData();
//     // setState(() {});
//     if (dataChart != null) {
//       setState(() {
//         print("SeeetState");
//       });
//     }
//     print(dataChart);
//   }

//   Widget getChardWidget() {
//     if (dataChart == null) {
//       return Padding(
//         child: new CircularProgressIndicator(),
//         padding: EdgeInsets.symmetric(
//           vertical: ScreenUtil().setHeight(63),
//           horizontal: ScreenUtil().setWidth(145),
//         ),
//       );
//     } else {
//       return _currencyChartData.currencyChartDashboard(dataChart);
//     }
//   }

//   @override
//   void initState() {
//     getChhhart();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Setstate triggered");
//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle(systemNavigationBarColor: kPrimaryColor),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   child: Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(ScreenUtil().setSp(10)),
//                       child: Text(
//                         "Dashboard",
//                         style: GoogleFonts.hammersmithOne(
//                             fontSize: ScreenUtil().setSp(41.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 11,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: kPrimaryColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(ScreenUtil().setSp(45.0)),
//                       topRight: Radius.circular(ScreenUtil().setSp(45.0)),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                           top: ScreenUtil().setHeight(20.0),
//                         ),
//                         child: Container(
//                             height: ScreenUtil().setHeight(190.0),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: kSecondaryColor,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(
//                                     ScreenUtil().setSp(44),
//                                   ),
//                                   topRight: Radius.circular(
//                                     ScreenUtil().setSp(44),
//                                   )),
//                             ),
//                             child: getChardWidget()),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
