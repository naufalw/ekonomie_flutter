import 'package:Ekonomie/constants/constants.dart';
import 'package:Ekonomie/screen/hasilPajakPBB_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:prefs/prefs.dart';

class PBBHomeScreen extends StatefulWidget {
  @override
  _PBBHomeScreenState createState() => _PBBHomeScreenState();
}

class _PBBHomeScreenState extends State<PBBHomeScreen> {
  var pilihanMode = ["Auto", "20%", "40%"];
  var pilihanModeNJOPKP = ["Diketahui", "Tidak Diketahui"];
  var dropdownModeValue;
  var nNJOPKPmodeValue;
  double nNJOKP = 0;
  double nNJOP = 0;
  double nNJOPTKP = 0;

  Future<void> getPrefsValue() async {
    dropdownModeValue = await Prefs.getStringF("PBBMode", pilihanMode[0]);
    nNJOPKPmodeValue = await Prefs.getStringF("NJOPMode", pilihanMode[0]);
    if (dropdownModeValue != null) {
      setState(() {});
    }
  }

  Widget getTextField() {
    if (nNJOPKPmodeValue == "Diketahui") {
      return PBBTextField(
        onChanged: (value) {
          nNJOKP = double.tryParse(value);
        },
        title: "NJOPKP",
      );
    } else {
      return Column(
        children: [
          PBBTextField(
            onChanged: (value) {
              nNJOP = double.tryParse(value);
            },
            title: "NJOP",
          ),
          PBBTextField(
            onChanged: (value) {
              nNJOPTKP = double.tryParse(value);
            },
            title: "NJOPTKP",
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    getPrefsValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          "Hitung PBB",
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            getTextField(),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(12),
                      ScreenUtil().setSp(5),
                      ScreenUtil().setSp(7),
                      ScreenUtil().setSp(5)),
                  child: NeuCard(
                      curveType: CurveType.emboss,
                      alignment: Alignment.center,
                      bevel: 0,
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setWidth(110),
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
                              value: dropdownModeValue,
                              items: pilihanMode.map((e) {
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
                                await Prefs.setString("PBBMode", value);
                                setState(() {
                                  dropdownModeValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(3),
                      ScreenUtil().setSp(5),
                      ScreenUtil().setSp(12),
                      ScreenUtil().setSp(5)),
                  child: NeuCard(
                      curveType: CurveType.emboss,
                      alignment: Alignment.center,
                      bevel: 0,
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setWidth(215),
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
                              value: nNJOPKPmodeValue,
                              items: pilihanModeNJOPKP.map((e) {
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
                                await Prefs.setString("NJOPMode", value);
                                setState(() {
                                  nNJOPKPmodeValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setSp(8)),
              child: Container(
                height: ScreenUtil().setHeight(55),
                width: ScreenUtil().setWidth(240),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PBBHasilScreen(
                                    nNJOP: nNJOP,
                                    nNJOPKP: nNJOKP,
                                    nNJOPTKP: nNJOPTKP,
                                  )));
                    },
                    child: Text(
                      "Hitung",
                      style: GoogleFonts.secularOne(
                          fontSize: ScreenUtil().setSp(28)),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PBBTextField extends StatelessWidget {
  final Function onChanged;
  final String title;
  const PBBTextField({@required this.title, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 12.0, vertical: ScreenUtil().setHeight(7)),
      child: NeuCard(
        bevel: 1.2,
        curveType: CurveType.emboss,
        decoration: NeumorphicDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(ScreenUtil().setSp(15))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: NeuTextField(
            onChanged: onChanged,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            scrollPadding: EdgeInsets.zero,
            style: GoogleFonts.secularOne(
                letterSpacing: 0.5, fontSize: ScreenUtil().setSp(29)),
            autocorrect: false,
            toolbarOptions:
                ToolbarOptions(copy: true, paste: true, selectAll: true),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration.collapsed(
              hintText: title,
              fillColor: kAlternateButtonColor,
              focusColor: kAlternateButtonColor,
            ),
          ),
        ),
      ),
    );
  }
}
