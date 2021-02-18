import 'package:Ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:prefs/prefs.dart';

class PendapatanNasionalScreen extends StatefulWidget {
  @override
  _PendapatanNasionalScreenState createState() =>
      _PendapatanNasionalScreenState();
}

class _PendapatanNasionalScreenState extends State<PendapatanNasionalScreen> {
  List metodePendapatanNasional = ["Pengeluaran", "Pemasukan"];
  String selectedMetode;
  void getAllStuff() async {
    selectedMetode =
        await Prefs.getStringF("MetodePendapatanNasional", "Pengeluaran");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBGColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          "Pendapatan Nasional",
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text("Metode",
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
                          value: selectedMetode,
                          items: metodePendapatanNasional.map((e) {
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
                                "MetodePendapatanNasional", value);
                            setState(() {
                              selectedMetode = value;
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
