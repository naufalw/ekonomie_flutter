import 'package:Ekonomie/backend/chart_currency.dart';
import 'package:Ekonomie/constants/constants.dart';
import 'package:Ekonomie/screen/calc_screen_alternative.dart';
import 'package:Ekonomie/screen/pajakPBB_screen.dart';
import 'package:Ekonomie/screen/settings_screen.dart';
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
      setState(() {});
    }
  }

  void updateUI() {
    setState(() {});
  }

  Widget getChardWidget() {
    if (dataChart == null) {
      return Container(
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
              ScreenUtil().setSp(0), ScreenUtil().setSp(6), 0.0),
          child: _currencyChartData.newCurrencyChartDashboard(dataChart),
        ),
        height: ScreenUtil().setHeight(200),
      );
    }
  }

  @override
  void initState() {
    if (dataChart == null) {
      getChhhart();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: kPrimaryColor,
          systemNavigationBarColor: kScaffoldBGColor),
      child: Scaffold(
        backgroundColor: kScaffoldBGColor,
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(328),
              child: NeuomorphicContainer(
                width: double.infinity,
                style: NeuomorphicStyle.Flat,
                blur: 100,
                color: kPrimaryColor,
                intensity: 0.47,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenUtil().setSp(50)),
                    bottomRight: Radius.circular(ScreenUtil().setSp(50))),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                        child: Text("Dashboard",
                            style: GoogleFonts.hammersmithOne(
                                fontSize: ScreenUtil().setSp(45))),
                      ),
                      getChardWidget(),
                      SizedBox(
                        height: ScreenUtil().setHeight(9),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(357),
              child: Container(
                width: double.infinity,
                child: NotificationListener(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return;
                  },
                  child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(6)),
                      child: Column(
                        children: [
                          DashBoardButton(
                            title: "Pendapatan Nasional",
                            onPressed: () {},
                          ),
                          DashBoardButton(
                            title: "Pajak Penghasilan",
                            onPressed: () {},
                          ),
                          DashBoardButton(
                            title: "Pajak Bumi Bangunan",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PBBHomeScreen()));
                            },
                          ),
                          DashBoardButton(
                            title: "Kalkulator",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CalcScreenNew()));
                            },
                          ),
                          DashBoardButton(
                            title: "Pengaturan",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PengaturanScreen()));
                            },
                          ),
                        ],
                      )),
                ),
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
  const DashBoardButton({@required this.title, @required this.onPressed});
  final String title;
  final Function onPressed;
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
          onPressed: onPressed,
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
