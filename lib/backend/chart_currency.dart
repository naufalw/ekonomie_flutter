import 'package:bezier_chart/bezier_chart.dart';
import 'package:dio/dio.dart';
import 'package:ekonomie/contants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CurrencyChartData {
  Future<List<DataPoint>> getChartData() async {
    Dio dio = new Dio();
    String fromCurrency = "USD";
    String toCurrency = "IDR";
    String symbolnya = "?symbols=$toCurrency&base=$fromCurrency";
    String url = "https://api.exchangerate.host/";
    // var dmin1 = Jiffy().subtract(days: 1).toString().split(" ")[0];
    // var hargadmin1 = await dio.get("$url$dmin1$symbolnya");
    List<DataPoint> dataChart = new List();
    for (var i = 1; i <= 5; i++) {
      DateTime dminDT = Jiffy().subtract(days: i);
      var dmin = Jiffy().subtract(days: i).toString().split(" ")[0];
      var hargadmin = await dio.get("$url$dmin$symbolnya");
      var dataCurrency = hargadmin.data["rates"][toCurrency];
      dataChart.add(
        DataPoint<DateTime>(value: dataCurrency.roundToDouble(), xAxis: dminDT),
      );
    }
    // print(hargadmin1.data["rates"][toCurrency].round());
    // int num = 1;
    return dataChart;
  }

  Future<List<ChartDataFormat>> newDataChart() async {
    Dio dio = new Dio();
    String fromCurrency = "USD";
    String toCurrency = "IDR";
    String symbolnya = "?symbols=$toCurrency&base=$fromCurrency";
    String url = "https://api.exchangerate.host/";
    // var dmin1 = Jiffy().subtract(days: 1).toString().split(" ")[0];
    // var hargadmin1 = await dio.get("$url$dmin1$symbolnya");
    List<ChartDataFormat> dataChart = new List();
    for (var i = 1; i <= 30; i++) {
      DateTime dminDT = Jiffy().subtract(days: i);
      var dmin = Jiffy().subtract(days: i).toString().split(" ")[0];
      var hargadmin = await dio.get("$url$dmin$symbolnya");
      var dataCurrency = hargadmin.data["rates"][toCurrency];
      dataChart.add(ChartDataFormat(dminDT, dataCurrency.round()));
    }
    // print(hargadmin1.data["rates"][toCurrency].round());
    // int num = 1;
    return dataChart;
  }

  Widget newCurrencyChartDashboard(List<ChartDataFormat> dataSource) {
    return Center(
      child: Container(
        child: SfCartesianChart(
          primaryYAxis: NumericAxis(),
          primaryXAxis: DateTimeAxis(),
          series: <ChartSeries>[
            LineSeries<ChartDataFormat, DateTime>(
                color: kSecondaryColor,
                width: 4.0,
                dataSource: dataSource,
                enableTooltip: true,
                xValueMapper: (ChartDataFormat cdf, int) => cdf.date,
                yValueMapper: (ChartDataFormat cdf, int) => cdf.rates)
          ],
        ),
      ),
    );
  }

  Widget currencyChartDashboard(List data) {
    final fromDate = Jiffy().subtract(days: 5);
    final selectedDate = Jiffy().subtract(days: 1);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil().setSp(45.0)),
            topRight: Radius.circular(ScreenUtil().setSp(45.0)),
          ),
        ),
        child: BezierChart(
          fromDate: fromDate,
          toDate: selectedDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          selectedDate: selectedDate,
          series: [
            BezierLine(
              data: data,
            )
          ],
          config: BezierChartConfig(
            showDataPoints: true,
            stepsYAxis: 1,
            startYAxisFromNonZeroValue: true,
            updatePositionOnTap: true,
            displayLinesXAxis: true,
            showVerticalIndicator: true,
            verticalIndicatorColor: kBottomBGColor,
          ),
        ),
      ),
    );
  }

  Widget sample3(BuildContext context) {
    final fromDate = DateTime(2019, 05, 22);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Duty",
              onMissingValue: (dateTime) {
                if (dateTime.day.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.red,
            footerHeight: 30.0,
          ),
        ),
      ),
    );
  }
}

class ChartDataFormat {
  ChartDataFormat(this.date, this.rates);
  final dynamic date;
  final num rates;
}
