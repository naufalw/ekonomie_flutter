import 'package:backdrop_modal_route/backdrop_modal_route.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:ekonomie/backend/hitung_pajak.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_input_formatters/currency_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

class PajakPenghasilanScreen extends StatefulWidget {
  @override
  _PajakPenghasilanScreenState createState() => _PajakPenghasilanScreenState();
}

class _PajakPenghasilanScreenState extends State<PajakPenghasilanScreen> {
  String selectedPKPMethod;
  double nPKP;
  double nPenghasilan;
  bool statusNikah = false;
  bool statusNPWP = false;
  bool penghasilanDigabung = false;
  List<String> allPKPMethod = ["Diketahui", "Tidak Diketahui"];
  List<String> jumlahTanggungan = ["0", "1", "2", "Diatas 2"];
  String nTanggungan;
  var nPPH = 0.0;
  String jmlTanggungan;

  Widget getAllWidget() {
    if (selectedPKPMethod == "Diketahui") {
      return PajakPenghasilanTextField(
        title: "PKP",
        onChanged: (val) {
          nPKP = double.tryParse(val.split(".").join());
        },
      );
    } else if (selectedPKPMethod == "Tidak Diketahui") {
      return Column(
        children: [
          PajakPenghasilanTextField(
            title: "Penghasilan",
            onChanged: (val) {
              nPenghasilan = double.tryParse(val.split(".").join());
            },
          ),
          CheckboxListTile(
            activeColor: kSecondaryColor,
            value: statusNPWP,
            title: AutoSizeText(
              "Wajib Pajak Orang Pribadi",
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
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "Tanggungan Keluarga :",
                style: GoogleFonts.secularOne(
                  fontSize: ScreenUtil().setSp(15),
                ),
                maxLines: 1,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
            child: DropdownButton(
              dropdownColor: kPrimaryColor,
              isExpanded: true,

              // hint: AutoSizeText("Tanggungan Keluarga",
              //     style: GoogleFonts.secularOne(
              //         fontSize: ScreenUtil().setSp(15), color: Colors.white)),
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
              value: nTanggungan ?? "0",
              onChanged: (val) {
                setState(() {
                  nTanggungan = val;
                  if (val == "Diatas 2") {
                    jmlTanggungan = "3";
                  } else {
                    jmlTanggungan = val;
                  }
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

  void getValue() {
    if (selectedPKPMethod == "Diketahui") {
      nPPH = getPPHKetemuPKP(nPKP);
    } else if (selectedPKPMethod == "Tidak Diketahui") {
      nPPH = getPPHGatauPKP(nPenghasilan ?? 0, statusNPWP, statusNikah,
          penghasilanDigabung, jmlTanggungan ?? "0");
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
                      spread: 0,
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
              Padding(
                padding: EdgeInsets.all(ScreenUtil().setSp(8)),
                child: Container(
                  width: ScreenUtil().setWidth(220),
                  child: NeumorphicButton(
                      style: NeumorphicStyle(
                          color: kSecondaryColor,
                          shadowDarkColor: kPrimaryColor,
                          shadowLightColor: kPrimaryColor,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(21))),
                      onPressed: () async {
                        getValue();
                        var hasilFormatted = NumberFormat.currency(
                                locale: "id", symbol: "", decimalDigits: 0)
                            .format(nPPH);
                        Navigator.push(
                            context,
                            BackdropModalRoute<void>(
                                barrierLabelVal: "Hasil",
                                topPadding: ScreenUtil().setHeight(200),
                                canBarrierDismiss: true,
                                safeAreaRight: true,
                                safeAreaTop: true,
                                backgroundColor: kScaffoldBGColor,
                                overlayContentBuilder: (context) {
                                  return ModalHasilSheet(
                                    hasilText: hasilFormatted,
                                  );
                                }));
                      },
                      child: Text(
                        "Hitung",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.secularOne(
                            fontSize: ScreenUtil().setSp(28)),
                      )),
                ),
              ),
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

class ModalHasilSheet extends StatefulWidget {
  const ModalHasilSheet({this.hasilText});
  final hasilText;
  @override
  _ModalHasilSheetState createState() => _ModalHasilSheetState();
}

class _ModalHasilSheetState extends State<ModalHasilSheet> {
  String hasilText;
  @override
  void initState() {
    hasilText = widget.hasilText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setSp(12.0)),
            child: GestureDetector(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              Text(
                "Tarif PPh",
                style: GoogleFonts.secularOne(fontSize: ScreenUtil().setSp(45)),
              ),
              Padding(
                padding: EdgeInsets.all(ScreenUtil().setSp(20.0)),
                child: AutoSizeText(
                  hasilText ?? "0",
                  maxLines: 1,
                  style: GoogleFonts.secularOne(
                    fontSize: ScreenUtil().setSp(80),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ScreenUtil().setSp(8)),
          child: Container(
            height: ScreenUtil().setHeight(55),
            width: ScreenUtil().setWidth(240),
            child: NeumorphicButton(
                style: NeumorphicStyle(
                    color: kSecondaryColor,
                    shadowDarkColor: kPrimaryColor,
                    shadowLightColor: kPrimaryColor,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(21))),
                // style: ElevatedButton.styleFrom(
                //   elevation: 3,
                //   primary: kSecondaryColor,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(21)),
                // ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Tutup",
                  style: GoogleFonts.secularOne(
                    fontSize: ScreenUtil().setSp(28),
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ],
    );
  }
}
