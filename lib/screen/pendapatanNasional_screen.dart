import 'package:clay_containers/clay_containers.dart';
import 'package:ekonomie/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';
import 'package:currency_input_formatters/currency_input_formatters.dart';
import 'package:backdrop_modal_route/backdrop_modal_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekonomie/backend/pendapatanNasional_brain.dart';

class PendapatanNasionalScreen extends StatefulWidget {
  @override
  _PendapatanNasionalScreenState createState() =>
      _PendapatanNasionalScreenState();
}

class _PendapatanNasionalScreenState extends State<PendapatanNasionalScreen> {
  List metodePendapatanNasional = ["Pengeluaran", "Pemasukan"];
  String selectedMetode;
  double c = 0,
      investasi = 0,
      g = 0,
      xport = 0,
      mport = 0,
      r = 0,
      w = 0,
      interest = 0,
      p = 0;
  double hasil = 0;

  void getAllStuff() async {
    selectedMetode = await Prefs.getStringF(
        "MetodePendapatanNasional", metodePendapatanNasional[0]);
    if (selectedMetode != null) {
      setState(() {});
    }
  }

  void getValue() {
    if (selectedMetode == "Pengeluaran") {
      hasil = getPendapatanNasionalPengeluaran(
          c ?? 0, investasi ?? 0, g ?? 0, xport ?? 0, mport ?? 0);
    } else if (selectedMetode == "Pemasukan") {
      hasil =
          getPendapatanNasionalPemasukan(r ?? 0, w ?? 0, interest ?? 0, p ?? 0);
    }
  }

  @override
  void initState() {
    getAllStuff();
    super.initState();
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
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Column(
            children: [
              Text("Metode",
                  textAlign: TextAlign.left,
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
                      parentColor: kSecondaryColor,
                      surfaceColor: kSecondaryColor,
                      curveType: CurveType.convex,
                      spread: 1.1,
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
                              value: selectedMetode,
                              items: metodePendapatanNasional.map((e) {
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
              ),
              getListWidget(),
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
                            .format(hasil);
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

  Widget getListWidget() {
    if (selectedMetode == "Pengeluaran") {
      return Column(
        children: [
          PendapatanNasionalTextField(
            title: "Konsumsi (C)",
            onChanged: (value) {
              c = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Investasi (I)",
            onChanged: (value) {
              investasi = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Pemerintah (G)",
            onChanged: (value) {
              g = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Ekspor (X)",
            onChanged: (value) {
              xport = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Impor (M)",
            onChanged: (value) {
              mport = double.tryParse(value.split(".").join());
            },
          ),
        ],
      );
    } else if (selectedMetode == "Pemasukan") {
      return Column(
        children: [
          PendapatanNasionalTextField(
            title: "Sewa (R)",
            onChanged: (value) {
              r = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Upah (W)",
            onChanged: (value) {
              w = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Bunga (I)",
            onChanged: (value) {
              interest = double.tryParse(value.split(".").join());
            },
          ),
          PendapatanNasionalTextField(
            title: "Laba (P)",
            onChanged: (value) {
              p = double.tryParse(value.split(".").join());
            },
          ),
        ],
      );
    } else {
      return Container();
    }
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
                "Hasil",
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

class PendapatanNasionalTextField extends StatelessWidget {
  final Function onChanged;
  final String title;
  const PendapatanNasionalTextField({@required this.title, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 12.0, vertical: ScreenUtil().setHeight(7)),
      child: ClayContainer(
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
                letterSpacing: 0.5, fontSize: ScreenUtil().setSp(29)),
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
