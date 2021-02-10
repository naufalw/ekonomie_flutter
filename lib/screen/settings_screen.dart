import 'package:Ekonomie/constants/constants.dart';
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
  var pilihanGraphDropDown;
  void getValueMess() async {
    pilihanGraphDropDown = await Prefs.getStringF("graphmode", pilihanGraph[0]);
    if (pilihanGraphDropDown != null) {
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
                  ScreenUtil().setSp(5),
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
          ],
        ),
      ),
    );
  }
}
