import 'package:clay_containers/clay_containers.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:google_fonts/google_fonts.dart';
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
    "SAR",
    "SGD",
    "USD",
  ];
  var fromCurrency;
  int modeIndex;
  var toCurrency;
  void getValueMess() async {
    modeIndex = await Prefs.getIntF("modeGrafik", 0);
    fromCurrency = await Prefs.getStringF("fromCurrency", currencyList[10]);
    toCurrency = await Prefs.getStringF("toCurrency", currencyList[4]);
    if (modeIndex != null && fromCurrency != null && toCurrency != null) {
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
    return Scaffold(
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
            Navigator.pop(context);
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
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new NeumorphicTheme(
                      themeMode: ThemeMode.light,
                      theme: NeumorphicThemeData.dark().copyWith(
                          baseColor: Colors.transparent,
                          shadowLightColor: Colors.transparent,
                          shadowDarkColor: Colors.transparent),
                      child: NeumorphicToggle(
                        alphaAnimationCurve: Curves.bounceInOut,
                        movingCurve: Curves.bounceInOut,
                        height: ScreenUtil().setHeight(45),
                        displayForegroundOnlyIfSelected: false,
                        selectedIndex: modeIndex,
                        thumb: Container(),
                        style: NeumorphicToggleStyle(
                          depth: 0,
                          backgroundColor: kPrimaryColor,
                        ),
                        children: pilihanGraph.map((e) {
                          return ToggleElement(
                            background: Center(
                                child: Text(e,
                                    style: GoogleFonts.secularOne(
                                      fontSize: ScreenUtil().setSp(21),
                                      backgroundColor: kPrimaryColor,
                                    ))),
                            foreground: ClayContainer(
                              spread: 0.2,
                              parentColor: kSecondaryColor,
                              surfaceColor: kSecondaryColor,
                              curveType: CurveType.convex,
                              customBorderRadius: BorderRadius.circular(12),
                              child: Center(
                                  child: Text(
                                e,
                                style: GoogleFonts.secularOne(
                                    fontSize: ScreenUtil().setSp(21)),
                              )),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          await Prefs.setInt("modeGrafik", value);
                          await Prefs.setString(
                              "graphmode", pilihanGraph[value]);
                          setState(() {
                            modeIndex = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setSp(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("From Currency",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.hammersmithOne(
                              fontSize: ScreenUtil().setSp(17))),
                      Container(
                        alignment: Alignment.center,
                        child: ClayContainer(
                            spread: 0.2,
                            parentColor: kSecondaryColor,
                            surfaceColor: kSecondaryColor,
                            curveType: CurveType.convex,
                            height: ScreenUtil().setHeight(45),
                            width: ScreenUtil().setWidth(150),
                            customBorderRadius: BorderRadius.circular(12),
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
                      ),
                    ],
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15),
                  ),
                  Column(
                    children: [
                      Text("To Currency",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.hammersmithOne(
                              fontSize: ScreenUtil().setSp(17))),
                      Container(
                        alignment: Alignment.center,
                        child: ClayContainer(
                            spread: 0.2,
                            parentColor: kSecondaryColor,
                            surfaceColor: kSecondaryColor,
                            curveType: CurveType.convex,
                            height: ScreenUtil().setHeight(45),
                            width: ScreenUtil().setWidth(150),
                            customBorderRadius: BorderRadius.circular(12),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
