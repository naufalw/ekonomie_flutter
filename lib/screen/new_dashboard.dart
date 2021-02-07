import 'package:ekonomie/backend/chart_currency.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewDashboardPage extends StatefulWidget {
  @override
  _NewDashboardPageState createState() => _NewDashboardPageState();
}

class _NewDashboardPageState extends State<NewDashboardPage> {
  List<ChartDataFormat> dataChart;
  CurrencyChartData _currencyChartData = new CurrencyChartData();

  void getChhhart() async {
    print(dataChart);
    dataChart = await _currencyChartData.newDataChart();
    // setState(() {});
    if (dataChart != null) {
      setState(() {
        print("SeeetState");
        print(dataChart);
      });
    }
    print(dataChart);
  }

  Widget getChardWidget() {
    if (dataChart == null) {
      return Padding(
        child: new CircularProgressIndicator(),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(63),
          horizontal: ScreenUtil().setWidth(145),
        ),
      );
    } else {
      return Container(
        child: _currencyChartData.newCurrencyChartDashboard(dataChart),
        height: ScreenUtil().setHeight(190),
      );
    }
  }

  @override
  void initState() {
    getChhhart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBGColor,
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    boxShadow: [BoxShadow()],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(45),
                            bottomRight: Radius.circular(45))),
                  ),
                  onPressed: () {},
                  child: SafeArea(
                    child: Column(
                      children: [
                        Center(
                          child: Text("Dashboard",
                              style: GoogleFonts.hammersmithOne(
                                  fontSize: ScreenUtil().setSp(43))),
                        ),
                        Center(
                          child: Container(
                            child: getChardWidget(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(22)),
                  child: Column(
                    children: [
                      DashBoardButton(
                        title: "Pendapatan Nasional",
                      ),
                      DashBoardButton(
                        title: "Pajak Penghasilan",
                      ),
                      DashBoardButton(
                        title: "Pajak Bumi Bangunan",
                      ),
                      DashBoardButton(
                        title: "Kalkulator",
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class DashBoardButton extends StatelessWidget {
  const DashBoardButton({@required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(8.0),
          vertical: ScreenUtil().setHeight(6)),
      child: Container(
        height: ScreenUtil().setHeight(60),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            primary: kSecondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
          ),
          onPressed: () {},
          child: Center(
            child: Text(title,
                style: GoogleFonts.hammersmithOne(
                    fontSize: ScreenUtil().setSp(25))),
          ),
        ),
      ),
    );
  }
}
