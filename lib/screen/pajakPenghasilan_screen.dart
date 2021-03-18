import 'package:clay_containers/clay_containers.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_input_formatters/currency_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prefs/prefs.dart';

class PajakPenghasilanScreen extends StatefulWidget {
  @override
  _PajakPenghasilanScreenState createState() => _PajakPenghasilanScreenState();
}

class _PajakPenghasilanScreenState extends State<PajakPenghasilanScreen> {
  String selectedPKPMethod;
  int nPKP;
  int nPenghasilan;
  bool statusNikah = false;
  bool statusNPWP = false;
  bool penghasilanDigabung = false;
  List<String> allPKPMethod = ["Diketahui", "Tidak Diketahui"];
  List<String> jumlahTanggungan = ["1", "2", "Diatas 2"];
  String nTanggungan;

  Widget getAllWidget() {
    if (selectedPKPMethod == "Diketahui") {
      return PajakPenghasilanTextField(
        title: "PKP",
        onChanged: (val) {
          nPKP = int.tryParse(val.split(".").join());
        },
      );
    } else if (selectedPKPMethod == "Tidak Diketahui") {
      return Column(
        children: [
          PajakPenghasilanTextField(
            title: "Penghasilan",
            onChanged: (val) {
              nPenghasilan = int.tryParse(val.split(".").join());
            },
          ),
          CheckboxListTile(
            activeColor: kSecondaryColor,
            value: statusNPWP,
            title: AutoSizeText(
              "Wajib Pajak Orang Pribadi (ada NPWP)",
              style: GoogleFonts.secularOne(
                fontSize: ScreenUtil().setSp(15),
              ),
              maxLines: 1,
            ),
            onChanged: (val) {
              setState(() {
                statusNPWP = val;
              });
            },
          ),
          CheckboxListTile(
            activeColor: kSecondaryColor,
            value: statusNikah,
            title: AutoSizeText(
              "Sudah Menikah",
              style: GoogleFonts.secularOne(
                fontSize: ScreenUtil().setSp(15),
              ),
              maxLines: 1,
            ),
            onChanged: (val) {
              setState(() {
                statusNikah = val;
              });
            },
          ),
          CheckboxListTile(
            activeColor: kSecondaryColor,
            value: penghasilanDigabung,
            title: AutoSizeText(
              "Penghasilan Digabung",
              style: GoogleFonts.secularOne(
                fontSize: ScreenUtil().setSp(15),
              ),
              maxLines: 1,
            ),
            onChanged: (val) {
              setState(() {
                penghasilanDigabung = val;
              });
            },
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
            child: DropdownButton(
              dropdownColor: kPrimaryColor,
              isExpanded: true,
              hint: AutoSizeText("Tanggungan Keluarga",
                  style: GoogleFonts.secularOne(
                      fontSize: ScreenUtil().setSp(15), color: Colors.white)),
              items: jumlahTanggungan.map((e) {
                return DropdownMenuItem(
                  child: Center(
                    child: Text(
                      e,
                      style: GoogleFonts.secularOne(
                        fontSize: ScreenUtil().setSp(22),
                      ),
                    ),
                  ),
                  value: e,
                );
              }).toList(),
              value: nTanggungan,
              onChanged: (val) {
                setState(() {
                  nTanggungan = val;
                });
              },
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  void getAllStuff() async {
    selectedPKPMethod = await Prefs.getStringF("PKP Method", allPKPMethod[0]);
    if (selectedPKPMethod != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getAllStuff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          "Pajak Penghasilan",
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Column(
            children: [
              Text("Status PKP",
                  style: GoogleFonts.hammersmithOne(
                      fontSize: ScreenUtil().setSp(17))),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(7),
                    ScreenUtil().setSp(2),
                    ScreenUtil().setSp(7),
                    ScreenUtil().setSp(5)),
                child: Container(
                  alignment: Alignment.center,
                  child: ClayContainer(
                      borderRadius: 21,
                      parentColor: kSecondaryColor,
                      surfaceColor: kSecondaryColor,
                      curveType: CurveType.convex,
                      spread: 1,
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setWidth(340),
                      customBorderRadius: BorderRadius.circular(21),
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
                              value: selectedPKPMethod,
                              items: allPKPMethod.map((e) {
                                return DropdownMenuItem(
                                  child: Center(
                                      child: Text(
                                    e,
                                    style: GoogleFonts.secularOne(
                                        fontSize: ScreenUtil().setSp(22)),
                                  )),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) async {
                                await Prefs.setString("PKP Method", value);
                                setState(() {
                                  selectedPKPMethod = value;
                                });
                              },
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              getAllWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class PajakPenghasilanTextField extends StatelessWidget {
  final Function onChanged;
  final String title;
  const PajakPenghasilanTextField({@required this.title, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 12.0, vertical: ScreenUtil().setHeight(7)),
      child: ClayContainer(
        height: ScreenUtil().setHeight(44),
        spread: 1.3,
        color: kPrimaryColor,
        customBorderRadius: BorderRadius.circular(ScreenUtil().setSp(15)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            inputFormatters: [CurrencyFormatter()],
            onChanged: onChanged,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            scrollPadding: EdgeInsets.zero,
            style: GoogleFonts.secularOne(
                letterSpacing: 0.5, fontSize: ScreenUtil().setSp(25)),
            autocorrect: false,
            toolbarOptions:
                ToolbarOptions(copy: false, paste: false, selectAll: false),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
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
