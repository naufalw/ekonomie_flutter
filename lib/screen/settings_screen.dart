import 'package:Ekonomie/constants/constants.dart';
import 'package:Ekonomie/screen/new_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:prefs/prefs.dart';

class PengaturanScreen extends StatefulWidget {
  @override
  _PengaturanScreenState createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  List pilihanGraph = ["Line", "Area"];
  List currencyList = [
    "AUD",
    "BTC",
    "CNY",
    "EUR",
    "IDR",
    "INR",
    "MYR",
    "PHP",
    "SAD",
    "SGD",
    "USD",
  ];
  var fromCurrency;
  var toCurrency;
  var pilihanGraphDropDown;
  void getValueMess() async {
    pilihanGraphDropDown = await Prefs.getStringF("graphmode", pilihanGraph[0]);
    fromCurrency = await Prefs.getStringF("fromCurrency", currencyList[10]);
    toCurrency = await Prefs.getStringF("toCurrency", currencyList[4]);
    if (pilihanGraphDropDown != null &&
        fromCurrency != null &&
        toCurrency != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getValueMess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NewDashboardPage())),
      child: Scaffold(
        backgroundColor: kScaffoldBGColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "Pengaturan",
            style: GoogleFonts.secularOne(),
          ),
          elevation: 0.0,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NewDashboardPage()));
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Mode Grafik",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.hammersmithOne(
                      fontSize: ScreenUtil().setSp(17))),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(12),
                    ScreenUtil().setSp(2),
                    ScreenUtil().setSp(7),
                    ScreenUtil().setSp(5)),
                child: NeuCard(
                    curveType: CurveType.emboss,
                    alignment: Alignment.center,
                    bevel: 0,
                    height: ScreenUtil().setHeight(50),
                    width: ScreenUtil().setWidth(335),
                    decoration: NeumorphicDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: kAlternateButtonColor),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: GoogleFonts.secularOne(
                                fontSize: ScreenUtil().setSp(17)),
                            dropdownColor: kPrimaryColor,
                            elevation: 0,
                            isExpanded: true,
                            value: pilihanGraphDropDown,
                            items: pilihanGraph.map((e) {
                              return DropdownMenuItem(
                                child: Center(
                                    child: Text(
                                  e,
                                  style: GoogleFonts.secularOne(
                                      fontSize: ScreenUtil().setSp(21)),
                                )),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) async {
                              await Prefs.setString("graphmode", value);
                              setState(() {
                                pilihanGraphDropDown = value;
                              });
                            },
                          ),
                        ),
                      ),
                    )),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setSp(12),
                        ScreenUtil().setSp(5),
                        ScreenUtil().setSp(7),
                        ScreenUtil().setSp(5)),
                    child: Column(
                      children: [
                        Text("From Currency",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.hammersmithOne(
                                fontSize: ScreenUtil().setSp(17))),
                        NeuCard(
                            curveType: CurveType.emboss,
                            alignment: Alignment.center,
                            bevel: 0,
                            height: ScreenUtil().setHeight(50),
                            width: ScreenUtil().setWidth(162),
                            decoration: NeumorphicDecoration(
                                borderRadius: BorderRadius.circular(21),
                                color: kAlternateButtonColor),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    style: GoogleFonts.secularOne(
                                        fontSize: ScreenUtil().setSp(17)),
                                    dropdownColor: kPrimaryColor,
                                    elevation: 0,
                                    isExpanded: true,
                                    value: fromCurrency,
                                    items: currencyList.map((e) {
                                      return DropdownMenuItem(
                                        child: Center(
                                            child: Text(
                                          e,
                                          style: GoogleFonts.secularOne(
                                              fontSize: ScreenUtil().setSp(21)),
                                        )),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      await Prefs.setString(
                                          "fromCurrency", value);
                                      setState(() {
                                        fromCurrency = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setSp(3),
                        ScreenUtil().setSp(5),
                        ScreenUtil().setSp(12),
                        ScreenUtil().setSp(5)),
                    child: Column(
                      children: [
                        Text("To Currency",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.hammersmithOne(
                                fontSize: ScreenUtil().setSp(17))),
                        NeuCard(
                            curveType: CurveType.emboss,
                            alignment: Alignment.center,
                            bevel: 0,
                            height: ScreenUtil().setHeight(50),
                            width: ScreenUtil().setWidth(162),
                            decoration: NeumorphicDecoration(
                                borderRadius: BorderRadius.circular(21),
                                color: kAlternateButtonColor),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    style: GoogleFonts.secularOne(
                                        fontSize: ScreenUtil().setSp(17)),
                                    dropdownColor: kPrimaryColor,
                                    elevation: 0,
                                    isExpanded: true,
                                    value: toCurrency,
                                    items: currencyList.map((e) {
                                      return DropdownMenuItem(
                                        child: Center(
                                            child: Text(
                                          e,
                                          style: GoogleFonts.secularOne(
                                              fontSize: ScreenUtil().setSp(21)),
                                        )),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      await Prefs.setString(
                                          "toCurrency", value);
                                      setState(() {
                                        toCurrency = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
