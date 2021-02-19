import 'package:dio/dio.dart';
import 'package:Ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:prefs/prefs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CurrencyChartData {
  Future<List<ChartDataFormat>> newDataChart() async {
    Dio dio = new Dio();

    String fromCurrency = await Prefs.getStringF("fromCurrency", "USD");
    String toCurrency = await Prefs.getStringF("toCurrency", "IDR");
    String symbolnya = "?symbols=$toCurrency&base=$fromCurrency";
    String url = "https://api.exchangerate.host/";
    // var dmin1 = Jiffy().subtract(days: 1).toString().split(" ")[0];
    // var hargadmin1 = await dio.get("$url$dmin1$symbolnya");
    List<ChartDataFormat> dataChart = new List();
    for (var i = 1; i <= 7; i++) {
      DateTime dminDT = DateTime.now().subtract(Duration(days: i));
      var dmin =
          DateTime.now().subtract(Duration(days: i)).toString().split(" ")[0];
      var hargadmin = await dio.get("$url$dmin$symbolnya");
      var dataCurrency = hargadmin.data["rates"][toCurrency];
      dataChart.add(ChartDataFormat(dminDT, dataCurrency.round()));
    }
    // print(hargadmin1.data["rates"][toCurrency].round());
    // int num = 1;
    return dataChart;
  }

  ChartSeries getChartSeries(List<ChartDataFormat> dataSource) {
    if (Prefs.getString("graphmode") == "Area") {
      return SplineAreaSeries<ChartDataFormat, DateTime>(
          color: kSecondaryColor,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf12711),
              kSecondaryColor,
            ],
          ),
          // width: 4.0,
          dataSource: dataSource,
          enableTooltip: true,
          xValueMapper: (ChartDataFormat cdf, int) => cdf.date,
          yValueMapper: (ChartDataFormat cdf, int) => cdf.rates);
    } else {
      return LineSeries<ChartDataFormat, DateTime>(
          color: kSecondaryColor,
          width: 4.7,
          // width: 4.0,
          dataSource: dataSource,
          enableTooltip: true,
          xValueMapper: (ChartDataFormat cdf, int) => cdf.date,
          yValueMapper: (ChartDataFormat cdf, int) => cdf.rates);
    }
  }

  Widget newCurrencyChartDashboard(List<ChartDataFormat> dataSource) {
    String fromCurrency = Prefs.getString("fromCurrency", "USD");
    var toCurrency = Prefs.getString("toCurrency", "IDR");

    String textnya = "1 $fromCurrency to $toCurrency";
    return Center(
      child: Container(
        child: SfCartesianChart(
            title:
                ChartTitle(text: textnya, textStyle: GoogleFonts.secularOne()),
            primaryYAxis: NumericAxis(),
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              getChartSeries(dataSource),
            ],
            trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipSettings: InteractiveTooltip(
                    color: kAlternateButtonColor,
                    textStyle: TextStyle(color: Colors.white),
                    format: 'point.x : point.y',
                    borderWidth: 0))),
      ),
    );
  }
}

class ChartDataFormat {
  ChartDataFormat(this.date, this.rates);
  final dynamic date;
  final num rates;
}
