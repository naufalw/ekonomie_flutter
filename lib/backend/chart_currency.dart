import 'package:dio/dio.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CurrencyChartData {
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
}

class ChartDataFormat {
  ChartDataFormat(this.date, this.rates);
  final dynamic date;
  final num rates;
}
