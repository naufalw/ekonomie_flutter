import 'package:Ekonomie/backend/chart_currency.dart';
import 'package:Ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';

class NewDashboardPage extends StatefulWidget {
  @override
  _NewDashboardPageState createState() => _NewDashboardPageState();
}

class _NewDashboardPageState extends State<NewDashboardPage> {
  List<ChartDataFormat> dataChart;
  CurrencyChartData _currencyChartData = new CurrencyChartData();

  void getChhhart() async {
    dataChart = await _currencyChartData.newDataChart();
    // setState(() {});
    if (dataChart != null) {
      setState(() {
        print("SeeetState");
      });
    }
  }

  Widget getChardWidget() {
    if (dataChart == null) {
      return NeuCard(
        bevel: 7,
        curveType: CurveType.flat,
        decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.circular(40),
          color: kPrimaryColor,
        ),
        width: ScreenUtil().setWidth(330),
        child: Padding(
          child: new CircularProgressIndicator(),
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(63),
            horizontal: ScreenUtil().setWidth(125),
          ),
        ),
        height: ScreenUtil().setHeight(200),
      );
    } else {
      return NeuCard(
        bevel: 7,
        curveType: CurveType.flat,
        decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.circular(40),
          color: kPrimaryColor,
        ),
        width: ScreenUtil().setWidth(330),
        child: Padding(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(4),
              ScreenUtil().setSp(13), ScreenUtil().setSp(6), 0.0),
          child: _currencyChartData.newCurrencyChartDashboard(dataChart),
        ),
        height: ScreenUtil().setHeight(200),
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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
      child: Scaffold(
        backgroundColor: kScaffoldBGColor,
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: NeuomorphicContainer(
                style: NeuomorphicStyle.Flat,
                blur: 100,
                color: kPrimaryColor,
                intensity: 0.47,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenUtil().setSp(50)),
                    bottomRight: Radius.circular(ScreenUtil().setSp(50))),
                child: SafeArea(
                  child: Column(
                    children: [
                      Center(
                        child: Text("Dashboard",
                            style: GoogleFonts.hammersmithOne(
                                fontSize: ScreenUtil().setSp(45))),
                      ),
                      Center(
                        child: getChardWidget(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
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
      ),
    );
  }
}

class UpperElevatedButton extends StatelessWidget {
  const UpperElevatedButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
              child: Container(),
            )
          ],
        ),
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
            elevation: 6,
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
