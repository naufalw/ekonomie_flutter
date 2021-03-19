import 'package:clay_containers/clay_containers.dart';
import 'package:ekonomie/backend/chart_currency.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:ekonomie/screen/calc_screen_alternative.dart';
import 'package:ekonomie/screen/pajakPBB_screen.dart';
import 'package:ekonomie/screen/pajakPenghasilan_screen.dart';
import 'package:ekonomie/screen/pendapatanNasional_screen.dart';
import 'package:ekonomie/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    getChhhart();
    getChardWidget();
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
      return Container(
        child: ClayContainer(
          depth: 6,
          customBorderRadius: BorderRadius.circular(40),
          color: kPrimaryColor,
          width: ScreenUtil().setWidth(330),
          child: Padding(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(4),
                ScreenUtil().setSp(0), ScreenUtil().setSp(6), 0.0),
            child: _currencyChartData.newCurrencyChartDashboard(dataChart),
          ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(328),
                child: NeuomorphicContainer(
                  width: double.infinity,
                  blur: 100,
                  color: kPrimaryColor,
                  intensity: 0.47,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(ScreenUtil().setSp(30)),
                      bottomRight: Radius.circular(ScreenUtil().setSp(30))),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                          child: ClayText("Dashboard",
                              depth: 18,
                              parentColor: kPrimaryColor,
                              style: GoogleFonts.hammersmithOne(
                                  fontSize: ScreenUtil().setSp(45))),
                        ),
                        getChardWidget(),
                        SizedBox(
                          height: ScreenUtil().setHeight(12),
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
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PendapatanNasionalScreen()));
                              },
                            ),
                            DashBoardButton(
                              title: "Pajak Penghasilan",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PajakPenghasilanScreen()));
                              },
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
                                                PengaturanScreen()))
                                    .then((value) => updateUI());
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
        child: NeumorphicButton(
          style: NeumorphicStyle(
              color: kSecondaryColor,
              shadowDarkColor: kPrimaryColor,
              shadowLightColor: kPrimaryColor,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(21))),
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
